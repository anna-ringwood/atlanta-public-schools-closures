# Impact of Closing Public Elementary School in Atlanta, GA

## Overview

For a public-friendly presentation of the project's results, click [here](https://storymaps.arcgis.com/stories/775ccf2cc3d840f1ae997d02c38c6ef2).

As of late 2025, Atlanta Public Schools (APS) has decided to close 10 elementary schools by 2027. This geospatial analysis uses Esri ArcGIS to visualize population characteristics of each elementary school zone and highlight areas where closures may disproportionately impact subgroups' reasonable walking access to elementary schools. A significant finding of the project is that, if school closures proceed as planned, an estimated 14,000 Black Atlantans will lose 15-minute walking access to an elementary school, which is 7x the estimated 2,000 white Atlantans projected to lose access. 

### How to Use This Repo

To explore the code and ArcGIS project, download this repository as a zip file onto your local machine. The main ArcGIS project file is `GISProjectAnnaRingwood.aprx`. The R project and `CleaningCensusData.R` file may require changes to path names.

## Introduction

For the past two years, APS has been working on the future of the district via its [APS Forward 2040 plan](https://www.fox5atlanta.com/news/atlanta-public-schools-aps-forward-closures-repurposing-vote). Declining enrollment and a predicted [$100M budget deficit for FY2026](https://civicatlanta.org/blog/2025-03-09-atlanta-public-schools-budget-gap) have spurred leaders to evaluate how facilities are being used and whether or not changes can bring about a more effective school system. After [more than 50 public meetings, over 7,600 survey responses, and nine task force updates](https://www.atlantapublicschools.us/cms/lib/GA01000924/Centricity/ModuleInstance/128868/Final%20APS%20Forward%202040%20Slides_HPM.pdf), the board voted on December 3, 2025 to close or repurpose 16 schools starting in 2027. 

Many residents have [spoken out against the plan](https://www.fox5atlanta.com/news/atlanta-public-schools-aps-forward-closures-repurposing-vote), arguing that proposed sites are located in predominantly Black areas in the city. The uneven distribution of closures is predicted to negatively impact communities by removing “critical neighborhood anchors:”  not only do these schools provide an education during the day, they also [serve as broader resources](https://www.cbsnews.com/atlanta/news/low-enrollment-some-atlanta-schools-history-housing-trends-family-choices/), offering afterschool programs, transportation, and health/dental services. Several factors contribute to declining enrollment and underutilized facilities, including [lower birth rates and increased housing costs and taxes](https://www.future-ed.org/k-12-public-school-enrollment-declines-explained/). Altogether, it is important to understand the complex dynamics between the roles that schools play, particularly in their immediate geographic area. If a school is removed from where it is needed, it will leave underserved communities at a disadvantage.

### Problem Statement

The goal of this project is to understand the demographic and socioeconomic characteristics of communities surrounding APS elementary schools, both those remaining open and those slated for closure. Identifying patterns will provide a better picture of the extent to which different communities will face impacts, while anticipating regional needs will prepare APS to support all families during the coming transition as they reevaluate how to get their children to school.

## Methods

Census data was collected at the tract level on variables including race, age, fertility, family structure, housing costs, transportation availability, and school enrollment. APS elementary school location data was also collected. Census tract data was transformed via the Tabulate Intersection and Summary Statistics tools in ArcGIS to map characteristics to APS elementary school zones. Several choropleth maps were then produced to facilitate visual comparison of various characteristics in relation to closed vs. open schools.

Prior to importing into ArcGIS, the data on Atlanta schools was combined from two sources (see Data Sources section) and augmented manually with columns to indicate the type of school (e.g., elementary, middle, etc.), the grade levels taught (e.g., K-5, PK-8, etc.), and whether or not the school was designated for closure/repurposing. Address correction was performed on a case-by-case basis to facilitate joining the data from the two sources. Once cleaned, the data was imported into ArcGIS and geocoding was used to convert the addresses of APS elementary schools to latitude-longitude coordinate pairs for mapping.

Network analyses of walking times to the elementary schools were conducted in ArcGIS for the scenarios before and after the proposed school closures. Intervals of 5, 10, and 15 minutes were used. Again, Tabulate Intersection and Summary Statistics were used to obtain data for which populations fell inside and outside of these service area intervals. Those living within a 5-minute walk of an elementary school were considered to have great access to the school. Those living within a 10- and 15-minute walk of an elementary school were considered to have good and reasonable access, respectively.

### Data Sources

Demographic and socioeconomic data was taken from the [American Community Survey (ACS) 5-year estimates for 2023](https://data.census.gov/table?q=demographics&g=050XX00US13057$1400000,13063$1400000,13067$1400000,13089$1400000,13097$1400000,13113$1400000,13117$1400000,13121$1400000,13135$1400000,13151$1400000,13247$1400000). Specific tables include Demographics and Housing Estimates (DP05), Means of Transportation to Work (B08301), Household Type (B11001), School Enrollment by Detailed Level of School for the Population 3 Years and Over (B14007), and Fertility (S1301). The data was filtered to include only tracts in the 11 counties that comprise the greater Atlanta area (Cherokee, Clayton, Cobb, DeKalb, Douglas, Fayette, Forsyth, Fulton, Gwinnett, Henry, and Rockdale).

APS elementary school zone shapefiles were obtained from a contact in Atlanta and used with permission. The zones are from the 2017-18 school year, and while they may not be entirely up-to-date, visual comparison with current zones posted on APS’s website reveal an acceptable level of similarity. APS elementary school location data was obtained from both the North American Industry Classification System (NAICS) and the [National Center for Education Statistics (NCES)](https://nces.ed.gov/ccd/schoolsearch/school_list.asp?Search=1&InstName=&SchoolID=&Address=&City=&State=13&Zip=&Miles=&County=&PhoneAreaCode=&Phone=&DistrictName=Atlanta+Public+Schools&DistrictID=&SchoolType=1&SchoolType=2&SchoolType=3&SchoolType=4&SpecificSchlTypes=all&IncGrade=-1&LoGrade=-1&HiGrade=-1). While the NAICS data contained latitude and longitude points, further exploration revealed some inaccuracies. Thus, the NCES street addresses were cleaned and geocoded in ArcGIS to ensure accuracy.

## Conclusion

This project confirms the fears of Atlanta residents that the schools being closed or repurposed are mostly in predominantly Black areas. It also looks at variables beyond race, including birth rates, household characteristics, accessibility via car and walking, and the surrounding youth population. The project highlights the decreased access to elementary schools among certain populations, specifically areas with high concentrations of Black people, recently-pregnant women, and higher-than-average elementary enrollment. These trends raise concerns regarding equity in the city’s education system, and ultimately leave many questions which warrant further attention.


### Future Directions

Using this project as a starting point, future endeavors should take a more longitudinal approach as opposed to a cross-sectional one. Identifying patterns of enrollment, domestic movement, and other characteristics will reveal a more holistic picture of the APS landscape and will increase the credibility of this undertaking. A second future direction would be to perform a cluster analysis of the various elementary school zones. Identifying common characteristics across the district would enable APS to better support both convergent and divergent needs. A final future direction would be to examine middle and high schools, since some of these are slated to be closed or repurposed as well. Further, parsing out charter, partner, and private schools will only benefit further exploration by augmenting the current project. In conclusion, while this project provides a solid foundation, additional effort is needed to fully understand the implications of APS school closures.

### Limitations

This analysis has its limitations. First, its exploratory nature cannot claim any causal relationships, only correlational. Further investigation is required if one wishes to draw causal conclusions from the data.” Second, the analysis doesn’t differentiate between public, charter, and partner elementary schools, and it ignores private schools entirely. Third, the ArcGIS tools used for analysis assume that populations are evenly distributed within a given polygon. The census tracts and ES zones are small enough that this may be true, but there is no guarantee. Finally, the APS elementary school zones are from more than five years ago and may no longer be entirely accurate.
