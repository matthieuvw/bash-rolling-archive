shell=/bin/bash

test:

	mkdir -p ./output
	./rolling-archive.sh ./test-files ./output

test-populate: test-clean

	mkdir -p ./test-files
	touch ./test-files/test-file1.txt
	touch ./test-files/test-file2.txt
	touch ./test-files/test-file3.txt

	mkdir -p ./output

	touch -t "$(shell date --date '-24 hours' "+%Y%m%d%H%M")" "./output/rolling-archive_hourly_deleteme_24.tar.gz"
	touch -t $(shell date --date '-30 hours' "+%Y%m%d%H%M") "./output/rolling-archive_hourly_deleteme_30.tar.gz"
	touch -t $(shell date --date '-99 hours' "+%Y%m%d%H%M") "./output/rolling-archive_hourly_deleteme_99.tar.gz"
	touch -t $(shell date --date '-23 hours' "+%Y%m%d%H%M") "./output/rolling-archive_hourly_keepme_23.tar.gz"
	touch -t $(shell date --date '-1 hours' "+%Y%m%d%H%M") "./output/rolling-archive_hourly_keepme_01.tar.gz"

	touch -t $(shell date --date '-7 days' "+%Y%m%d%H%M") "./output/rolling-archive_daily_deleteme_07.tar.gz"
	touch -t $(shell date --date '-30 days' "+%Y%m%d%H%M") "./output/rolling-archive_daily_deleteme_30.tar.gz"
	touch -t $(shell date --date '-99 days' "+%Y%m%d%H%M") "./output/rolling-archive_daily_deleteme_99.tar.gz"
	touch -t $(shell date --date '-6 days' "+%Y%m%d%H%M") "./output/rolling-archive_daily_keepme_06.tar.gz"
	touch -t $(shell date --date '-1 day' "+%Y%m%d%H%M") "./output/rolling-archive_daily_keepme_01.tar.gz"

	touch -t $(shell date --date '-5 weeks' "+%Y%m%d%H%M") "./output/rolling-archive_weekly_deleteme_05.tar.gz"
	touch -t $(shell date --date '-10 weeks' "+%Y%m%d%H%M") "./output/rolling-archive_weekly_deleteme_10.tar.gz"
	touch -t $(shell date --date '-99 weeks' "+%Y%m%d%H%M") "./output/rolling-archive_weekly_deleteme_99.tar.gz"
	touch -t $(shell date --date '-1 weeks' "+%Y%m%d%H%M") "./output/rolling-archive_weekly_keepme_01.tar.gz"
	touch -t $(shell date --date '-4 weeks' "+%Y%m%d%H%M") "./output/rolling-archive_weekly_keepme_04.tar.gz"

	touch -t $(shell date --date '-6 months' "+%Y%m%d%H%M") "./output/rolling-archive_monthly_deleteme_06.tar.gz"
	touch -t $(shell date --date '-10 months' "+%Y%m%d%H%M") "./output/rolling-archive_monthly_deleteme_10.tar.gz"
	touch -t $(shell date --date '-99 months' "+%Y%m%d%H%M") "./output/rolling-archive_monthly_deleteme_99.tar.gz"
	touch -t $(shell date --date '-1 months' "+%Y%m%d%H%M") "./output/rolling-archive_monthly_keepme_01.tar.gz"
	touch -t $(shell date --date '-5 months' "+%Y%m%d%H%M") "./output/rolling-archive_monthly_keepme_05.tar.gz"

	touch -t $(shell date --date '-2 years' "+%Y01010000") "./output/rolling-archive_yearly_deleteme_02.tar.gz"
	touch -t $(shell date --date '-10 years' "+%Y%m%d%H%M") "./output/rolling-archive_yearly_deleteme_10.tar.gz"
	touch -t $(shell date --date '-99 years' "+%Y%m%d%H%M") "./output/rolling-archive_yearly_deleteme_99.tar.gz"
	touch -t $(shell date "+%Y01010000") "./output/rolling-archive_yearly_keepme_00.tar.gz"
	touch -t $(shell date --date '-1 years' "+%Y%m%d%H%M") "./output/rolling-archive_yearly_keepme_01.tar.gz"

test-clean:

	if [ -d ./test-files ]; then rm -Rf ./test-files; fi

clean: test-clean

	if [ -d ./output ]; then rm -Rf ./output; fi
