Return-Path: <linux-ext4+bounces-320-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC748806F4A
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Dec 2023 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733A9281C1E
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Dec 2023 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2883588B;
	Wed,  6 Dec 2023 11:58:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDD38F;
	Wed,  6 Dec 2023 03:58:02 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SlbQT5QCfzShKJ;
	Wed,  6 Dec 2023 19:53:37 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 19:57:58 +0800
Message-ID: <51afdb12-0075-02a3-87ef-0ed54e8d2588@huawei.com>
Date: Wed, 6 Dec 2023 19:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
CC: Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
	<linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <ritesh.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <ZXAyV/rlfvBBuDL1@dread.disaster.area>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZXAyV/rlfvBBuDL1@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/12/6 16:35, Dave Ch inner wrote:
> On Mon, Dec 04, 2023 at 09:50:18PM +0800, Baokun Li wrote:
>> On 2023/12/4 20:11, Jan Kara wrote:
>>> Hello!
>> Thank you for your reply!
>>> On Sat 02-12-23 17:14:30, Baokun Li wrote:
>>>> Recently, while running some pressure tests on MYSQL, noticed that
>>>> occasionally a "corrupted data in log event" error would be reported.
>>>> After analyzing the error, I found that extending DIO write and buffered
>>>> read were competing, resulting in some zero-filled page end being read.
>>>> Since ext4 buffered read doesn't hold an inode lock, and there is no
>>>> field in the page to indicate the valid data size, it seems to me that
>>>> it is impossible to solve this problem perfectly without changing these
>>>> two things.
>>> Yes, combining buffered reads with direct IO writes is a recipe for
>>> problems and pretty much in the "don't do it" territory. So honestly I'd
>>> consider this a MYSQL bug. Were you able to identify why does MYSQL use
>>> buffered read in this case? It is just something specific to the test
>>> you're doing?
>> The problem is with a one-master-twoslave MYSQL database with three
>> physical machines, and using sysbench pressure testing on each of the
>> three machines, the problem occurs about once every two to three hours.
>>
>> The problem is with the relay log file, and when the problem occurs, the
>> middle dozens of bytes of the file are read as all zeros, while the data on
>> disk is not. This is a journal-like file where a write process gets the data
>> from
>> the master node and writes it locally, and another replay process reads the
>> file and performs the replay operation accordingly (some SQL statements).
>> The problem is that when replaying, it finds that the data read is
>> corrupted,
>> not valid SQL data, while the data on disk is normal.
>>
>> It's not confirmed that buffered reads vs direct IO writes is actually
>> causing
>> this issue, but this is the only scenario that we can reproduce with our
>> local
>> simplified scripts. Also, after merging in patch 1, the MYSQL pressure test
>> scenario has now been tested for 5 days and has not been reproduced.
> Mixing overlapping buffered read with direct writes - especially partial block
> extending DIO writes - is a recipe for data corruption. It's not a
> matter of if, it's a matter of when.
>
> Fundamentally, when you have overlapping write IO involving DIO, the
> result of the overlapping IOs is undefined. One cannot control
> submission order, the order that the overlapping IO hit the
> media, or completion ordering that might clear flags like unwritten
> extents. The only guarantee that we give in this case is that we
> won't expose stale data from the disk to the user read.
>
> As such, it is the responsibility of the application to avoid
> overlapping IOs when doing direct IO. The fact that you['ve observed
> data corruption due to overlapping IO ranges from the one
> application indicates that this is, indeed, an application level
> problem and can only be solved by fixing the application....
OK, thank you very much for your detailed explanation!
>> I'll double-check the problem scenario, although buffered reads with
>> buffered
>> writes doesn't seem to have this problem.
>>>> In this series, the first patch reads the inode size twice, and takes the
>>>> smaller of the two values as the copyout limit to avoid copying data that
>>>> was not actually read (0-padding) into the user buffer and causing data
>>>> corruption. This greatly reduces the probability of problems under 4k
>>>> page. However, the problem is still easily triggered under 64k page.
>>>>
>>>> The second patch waits for the existing dio write to complete and
>>>> invalidate the stale page cache before performing a new buffered read
>>>> in ext4, avoiding data corruption by copying the stale page cache to
>>>> the user buffer. This makes it much less likely that the problem will
>>>> be triggered in a 64k page.
>>>>
>>>> Do we have a plan to add a lock to the ext4 buffered read or a field in
>>>> the page that indicates the size of the valid data in the page? Or does
>>>> anyone have a better idea?
>>> No, there are no plans to address this AFAIK. Because such locking will
>>> slow down all the well behaved applications to fix a corner case for
>>> application doing unsupported things. Sure we must not crash the kernel,
>>> corrupt the filesystem or leak sensitive (e.g. uninitialized) data if app
>>> combines buffered and direct IO but returning zeros instead of valid data
>>> is in my opinion fully within the range of acceptable behavior for such
>>> case.
>>>
>>> 								Honza
>> I also feel that a scenario like buffered reads + DIO writes is strange. But
>> theoretically when read doesn't return an error, the data read shouldn't be
>> wrong.
> The data that was read isn't wrong - it just wasn't what the
> application expected.
>
>> And I tested that xfs guarantees data consistency in this scenario, which is
>> why I
>> thought it might be buggy.
> XFS certainly does not guarantee data consistency between buffered
> reads and DIO writes, especially for overlapping IO ranges using DIO
> (see above).
>
> IOWs, the fact that the data inconsistency doesn't reproduce on XFS
> doesn't mean that XFS is providing some guarantee of consistency for
> this IO pattern. All it means is that ext4 and XFS behave differently
> in an situation where the operational result is indeterminate and all
> we guarantee is that we won't expose stale data read from disk....
>
> Cheers,
>
> Dave.
Here's my test script, just put all three shell scripts in the same 
directory,
change the disk and dir, then run `sh test-io.sh`, and the inconsistency is
reproduced under ext4 in just one round, and after switching the
filesystem to xfs, the problem is no longer reproduced. So it looks like
xfs guarantees consistency in this scenario. But you're right, a test case
can't trigger a problem doesn't mean the problem doesn't exist.
Thank you very much for the correction.

------ test-write.sh
disk="/dev/sda"
dir="/tmp/test"

write_t()
{
     pos=0
     touch $dir/writefile
     while [ $pos -lt 16777216 ]
     do
         xfs_io -c "open -d $dir/writefile" -c "pwrite -q -b 1024 -i 
$dir/testfile -s $pos $pos 1024" &> /dev/null
         pos=`ls -l $dir/writefile | awk '{print $5}'`
     done
}
write_t
------------------------------------------------------------

------ test-read.sh
disk="/dev/sda"
dir="/tmp/test"

read_t()
{
     pos=0
     touch $dir/readfile
     while [ $pos -lt 16777216 ]
     do
         xfs_io -c "open -d $dir/readfile" -c "pwrite -q -b 65536 -i 
$dir/writefile -s $pos $pos 65536" &> /dev/null
         pos=`ls -l $dir/readfile | awk '{print $5}'`
     done
}
read_t
------------------------------------------------------------

------ test-io.sh
disk="/dev/sda"
dir="/tmp/test"

mkdir -p $dir
umount $dir
mkfs.ext4 -F $disk
#mkfs.xfs -f -m crc=1,rmapbt=0,reflink=0 $disk
mount $disk $dir

xfs_io -f -c "pwrite -S 0xff 0 16777216" $dir/testfile
sync

round=0
while true
do
     while true
     do
         echo "******* round $round ********"

         touch $dir/writefile
         taskset 0x00000001 sh test-read.sh &
         pid_read=$!
         taskset 0x0000000f sh test-write.sh &
         pid_write=$!

         wait $pid_read
         wait $pid_write
         sync

         md_raw=`md5sum $dir/testfile | awk '{print $1}'`
         md_write=`md5sum $dir/writefile | awk '{print $1}'`
         md_read=`md5sum $dir/readfile | awk '{print $1}'`
         if [ $md_write != $md_raw ]
         then
             echo "write error csum"
             echo "raw csum: $md_raw"
             echo "write csum: $md_write"
             exit 1
         elif [ $md_read != $md_write ]
         then
             echo "raed error csum"
             echo "write csum: $md_write"
             echo "read csum: $md_read"
             exit 1
         fi

         rm -f $dir/writefile
         rm -f $dir/readfile
         sync
         round=$(($round+1))
     done
done
------------------------------------------------------------

Thanks!
-- 
With Best Regards,
Baokun Li
.

