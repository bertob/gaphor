#!/bin/bash
#
# Generate documentation pages for a model

M=$1

H1="=================================================="
H2="--------------------------------------------------"

if test "$M" == "core"
then
  cat > models/"$M".rst << EOF
Modeling Language Core
$H1

.. image:: $M/Core/main.svg

EOF
exit
elif test "$M" == "uml"
then
  cat > models/"$M".rst << EOF
Unified Modeling Language
$H1

.. image:: $M/00._Overview.svg

.. toctree::
  :caption: Packages
  :maxdepth: 1

EOF
else
  cat > models/"$M".rst << EOF
Systems Modeling Language
$H1

.. image:: $(basename "$M")/SysML.svg

.. toctree::
  :caption: Packages
  :maxdepth: 1

EOF
fi

find models/"$M" | while read -r PACKAGE
do
  if test -d models/"$M"/"$PACKAGE"
  then
    echo "  $(basename "$M")/${PACKAGE}" >> models/"$M".rst

    {
      echo "${PACKAGE//_/ }"
      echo $H1
      echo
      find models/"$M"/"${PACKAGE}" | while read -r DIAGRAM
      do
        name=${DIAGRAM%.svg}
        echo "${name//_/ }"
        echo $H2
        echo
        echo ".. thumbnail:: ${PACKAGE}/${DIAGRAM}"
        echo "  :group: ${PACKAGE}"
        echo
      done
    } > models/"$M"/"${PACKAGE}".rst
  fi
done
