# Type a script or drag a script file from your workspace to insert its path.
cd ../
IFS=$'\n'
check=0
pods="Pods"
carthage="Carthage"

# swiftlint --strict --config ./.swiftlint.yml

if which swiftlint >/dev/null; then
for filename in $(git diff --diff-filter=d --name-only | grep ".swift$")
do
# Added IF condition to ignore linting swift files in Pods, Carthage and generated GraphQLAPI files.
# Using --path alongwith --config overwrites excluded from the .swiftlint.yml file
root_directory=$(echo "$filename" | cut -d "/" -f-1)
if [ "$root_directory" != "$pods" ] && [ "$root_directory" != "$carthage" ]; then
echo "IN OTHER FILES"
swiftformat --swiftversion 5.3 "${filename}"
swiftlint autocorrect --config ./.swiftlint.auto.yml --path "${filename}" && swiftlint --strict --config ./.swiftlint.yml --path "${filename}"
else
echo "IN PODS"
fi

last_status=$?
check=$(($check | $last_status))
done

exit $check
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
exit 1
fi
