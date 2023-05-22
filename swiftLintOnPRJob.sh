IFS=$'\n'
check=0
pods="Pods"
carthage="Carthage"
baseBranch=$1
prBranch=$2

for filename in $(git diff --diff-filter=d --name-only "origin/$baseBranch"..."origin/$prBranch" | grep ".swift$")
do
root_directory=$(echo "$filename" | cut -d "/" -f-1)
if [ "$root_directory" != "$pods" ] && [ "$root_directory" != "$carthage" ]; then
echo "${filename}"
swiftlint --strict --config ./.swiftlint.yml --path "${filename}"
else
echo "IN PODS"
fi
last_status=$?
check=$(($check | $last_status))
done
exit $check
