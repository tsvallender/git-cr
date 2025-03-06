GIT_NOTES_REF=refs/notes/git-cr
POS_ARGS=()

while [[ $# -gt 0 ]]
do
  case $1 in
    -s|--sha)
      SHA="$2"
      shift ; shift
      ;;
    -f|--file)
      FILENAME="$2"
      shift ; shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POS_ARGS+=("$1")
      shift
      ;;
  esac
done
