Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4942913D72F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2020 10:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAPJrS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jan 2020 04:47:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgAPJrS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Jan 2020 04:47:18 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G9kosY057929
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2020 04:47:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfaw28hrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2020 04:47:13 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 16 Jan 2020 09:46:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 09:46:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00G9ktOq57933832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 09:46:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D248A405F;
        Thu, 16 Jan 2020 09:46:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF97FA405B;
        Thu, 16 Jan 2020 09:46:53 +0000 (GMT)
Received: from [9.199.159.45] (unknown [9.199.159.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 09:46:53 +0000 (GMT)
Subject: Re: Discussion: is it time to remove dioread_nolock?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
References: <20200109163802.GA33929@mit.edu>
 <20200114233054.890D7A4040@d06av23.portsmouth.uk.ibm.com>
 <20200115164829.GB165687@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 16 Jan 2020 15:16:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115164829.GB165687@mit.edu>
Content-Type: multipart/mixed;
 boundary="------------D66429D529101157068B4F61"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011609-4275-0000-0000-0000039808B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011609-4276-0000-0000-000038AC0729
Message-Id: <20200116094653.BF97FA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_03:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160082
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------D66429D529101157068B4F61
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ted,

On 1/15/20 10:18 PM, Theodore Y. Ts'o wrote:
> On Wed, Jan 15, 2020 at 05:00:53AM +0530, Ritesh Harjani wrote:
>>
>> I too collected some performance numbers on my x86 box with
>> --direct=1, bs=4K/1M & ioengine=libaio, with default opt v/s dioread_nolock
>> opt on latest ext4 git tree.
>>
>> I found the delta to be within +/- 6% in all of the runs which includes, seq
>> read, mixed rw & mixed randrw.
> 
> Thanks for taking the performance measurements!
> 
> Are you able to release more detail of what the deltas were for those
> tests?  And how stable were those results across repeated runs?
> 

I have collected these numbers using fio. All of the column values
shown in the attachment & pasted below are average of 3 runs.
I checked all those individual runs too and saw that even in the run-to-
run variations the delta was within +/- 5% only.

The naming of those individual runs *.json files are a bit weird and 
will take sometime if I have to publish the individual runs. But do let
me know if that as well is required. I can make some changes in the 
scripts to print individual run's numbers too.

I have pasted the individual fio files too which I used for my testing.
I have used libaio as ioengine (with iodepth=16) in the SeqRead case and
psync in others.


Performance numbers:
===================

(seq) read (4K) - libaio
============
threads     default_opt_read(MB/s)   dioread_nolock_opt_read(MB/s)
----------  ---------------------    ----------------------------
1           138.928059895833             138.824869791667 

8           129.345052083333             124.472005208333 

24          71.6555989583333             72.275390625


(Not sure why 24 thread case has lower perf numbers, but on increasing
the iodepth=32, I could see an increase in bw with 24 threads case
too.)


(seq) read (1M) - libaio
===========
threads     default_opt_read(MB/s)  dioread_nolock_opt_read(MB/s)
----------  ---------------------   ---------------
1           138.905598958333             138.832682291667 

8           111.263997395833             109.301106770833 

24          121.895182291667             127.75390625


randrw(4K)  - read (psync) 
 

========================== 

threads     default_opt_read [KB/s]  dioread_opt_read [KB/s] 

----------  ----------------    ---------------- 

1           414.666666666667    410.0 

8           780.0               792.333333333333 

24          967.333333333333    991.666666666667 


 
 

randrw(4K)  - write (psync) 

=========================== 

threads     default_opt_write [KB/s]  dioread_opt_write [KB/s] 

----------  -----------------    ----------------- 

1           418.0                413.666666666667 

8           796.666666666667     809.666666666667 

24          981.333333333333     1007.66666666667


randrw(1M) - read (psync)
=================
threads     default_opt_read(MB/s)   dioread_nolock_opt_read(MB/s)
----------  -----------------        -----------------------
1           39.5693359375                39.7288411458333 

8           44.5179036458333             47.9098307291667 

24          50.2861328125                51.720703125


randrw(1M) - write (psync)
==================
threads     default_opt_write(MB/s)  dioread_nolock_opt_write(MB/s)
----------  ----------------------   -----------------------
1           41.4583333333333              41.5068359375 

8           46.0768229166667              49.568359375 

24          49.5947265625                 50.7083333333333


rw(1M) - read (psync)
=============
threads     default_opt_read(MB/s)  dioread_nolock_opt_read(MB/s)
----------  ----------------------  -------------------
1           43.6458333333333             43.6770833333333 

8           48.1178385416667             49.2718098958333 

24          50.5703125                   53.7890625


rw(1M) - write (psync)
==============
threads     default_opt_write(MB/s)   dioread_nolock_opt_write(MB/s)
----------  -----------------------   ------------------
1           45.5065104166667               45.5654296875 

8           49.7431640625                  51.0690104166667 

24          50.2493489583333               53.3463541666667



FIO FILES
=========

dio_read.fio
============
[global]
         ioengine=libaio
         rw=read
         runtime=60
         iodepth=16
         direct=1
         size=10G
         filename=./testfile
         group_reporting=1
         thread=1
         ;bs=$bs
         ;numjobs=24

[fio-run]


dio_randrw.fio
==============
[global]
         ioengine=psync
         rw=randrw
         runtime=60
         iodepth=1
         direct=1
         size=10G
         filename=./testfile
         group_reporting=1
         thread=1
         ;bs=$bs
         ;numjobs=24

[fio-run]

dio_rw.fio
==========
[global]
         ioengine=psync
         rw=rw
         runtime=60
         iodepth=1
         direct=1
         size=10G
         filename=./testfile
         group_reporting=1
         thread=1
         ;bs=$bs
         ;numjobs=24

[fio-run]


Thanks
-ritesh



--------------D66429D529101157068B4F61
Content-Type: text/plain; charset=UTF-8;
 name="datafile.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="datafile.txt"

U2VxUmVhZCAoNEspIC0gbGliYWlvCj09PT09PT09PT09PQp0aHJlYWRzICAgICBkZWZhdWx0
X29wdFtyZWFkXzRLKE1CL3MpXSAgIGRpb3JlYWRfbm9sb2NrX29wdCBbcmVhZF80SyhNQi9z
KV0KLS0tLS0tLS0tLSAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KMSAgICAgICAgICAgMTM4LjkyODA1OTg5NTgzMyAgICAg
ICAgICAgICAxMzguODI0ODY5NzkxNjY3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCjggICAgICAgICAgIDEyOS4zNDUwNTIwODMzMzMgICAgICAgICAgICAgMTI0LjQ3
MjAwNTIwODMzMyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoyNCAgICAg
ICAgICA3MS42NTU1OTg5NTgzMzMzICAgICAgICAgICAgIDcyLjI3NTM5MDYyNSAgIAoKClNl
cVJlYWQoMU0pIC0gbGliYWlvCj09PT09PT09PT09CnRocmVhZHMgICAgIGRlZmF1bHRfb3B0
IFtyZWFkXzFNKE1CL3MpXSAgZGlvcmVhZF9ub2xvY2tfb3B0IFtyZWFkXzFNKE1CL3MpXQot
LS0tLS0tLS0tICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCjEgICAgICAgICAgIDEzOC45MDU1OTg5NTgzMzMgICAgICAg
ICAgICAgMTM4LjgzMjY4MjI5MTY2NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAo4ICAgICAgICAgICAxMTEuMjYzOTk3Mzk1ODMzICAgICAgICAgICAgIDEwOS4zMDEx
MDY3NzA4MzMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKMjQgICAgICAg
ICAgMTIxLjg5NTE4MjI5MTY2NyAgICAgICAgICAgICAxMjcuNzUzOTA2MjUgICAgICAKCgpy
YW5kcncoNEspICAtIHJlYWQgKHBzeW5jKQo9PT09PT09PT09PT09PT09PT09PT09PT09PQp0
aHJlYWRzICAgICBkZWZhdWx0X29wdF9yZWFkIFtLQi9zXSAgZGlvcmVhZF9vcHRfcmVhZCBb
S0Ivc10KLS0tLS0tLS0tLSAgLS0tLS0tLS0tLS0tLS0tLSAgCS0tLS0tLS0tLS0tLS0tLS0K
MSAgICAgICAgICAgNDE0LjY2NjY2NjY2NjY2NyAgCTQxMC4wCjggICAgICAgICAgIDc4MC4w
ICAgICAgICAgICAgIAk3OTIuMzMzMzMzMzMzMzMzCjI0ICAgICAgICAgIDk2Ny4zMzMzMzMz
MzMzMzMgIAk5OTEuNjY2NjY2NjY2NjY3CgoKcmFuZHJ3KDRLKSAgLSB3cml0ZSAocHN5bmMp
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PQp0aHJlYWRzICAgICBkZWZhdWx0X29wdF93
cml0ZSBbS0Ivc10gIGRpb3JlYWRfb3B0X3dyaXRlIFtLQi9zXQotLS0tLS0tLS0tICAtLS0t
LS0tLS0tLS0tLS0tLSAJIC0tLS0tLS0tLS0tLS0tLS0tICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKMSAgICAgICAgICAgNDE4LjAgICAgICAgICAgICAgCSA0MTMu
NjY2NjY2NjY2NjY3CjggICAgICAgICAgIDc5Ni42NjY2NjY2NjY2NjcgIAkgODA5LjY2NjY2
NjY2NjY2NwoyNCAgICAgICAgICA5ODEuMzMzMzMzMzMzMzMzICAJIDEwMDcuNjY2NjY2NjY2
NjcKCnJhbmRydygxTSkgLSByZWFkIChwc3luYykKPT09PT09PT09PT09PT09PT0KdGhyZWFk
cyAgICAgZGVmYXVsdF9vcHQgW3JlYWRfMU0oTUIvcykgICBkaW9yZWFkX25vbG9ja19vcHQg
W3JlYWRfMU0oTUIvcyldCi0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCjEgICAgICAgICAgIDM5LjU2
OTMzNTkzNzUgICAgICAgICAgICAgICAgMzkuNzI4ODQxMTQ1ODMzMyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCjggICAgICAgICAgIDQ0LjUxNzkwMzY0NTgzMzMg
ICAgICAgICAgICAgNDcuOTA5ODMwNzI5MTY2NyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCjI0ICAgICAgICAgIDUwLjI4NjEzMjgxMjUgICAgICAgICAgICAgICAg
NTEuNzIwNzAzMTI1ICAgICAgIAoKCnJhbmRydygxTSkgLSB3cml0ZSAocHN5bmMpCj09PT09
PT09PT09PT09PT09PQp0aHJlYWRzICAgICBkZWZhdWx0X29wdCBbd3JpdGVfMU0oTUIvcyld
ICBkaW9yZWFkX25vbG9ja19vcHQgW3dyaXRlXzFNKE1CL3MpXQotLS0tLS0tLS0tICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCjEgICAgICAgICAgIDQxLjQ1ODMzMzMzMzMzMzMgICAgICAgICAgICAgIDQxLjUw
NjgzNTkzNzUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKOCAg
ICAgICAgICAgNDYuMDc2ODIyOTE2NjY2NyAgICAgICAgICAgICAgNDkuNTY4MzU5Mzc1ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoyNCAgICAgICAgICA0
OS41OTQ3MjY1NjI1ICAgICAgICAgICAgICAgICA1MC43MDgzMzMzMzMzMzMzICAgICAgICAg
CgoKcncoMU0pIC0gcmVhZCAocHN5bmMpCj09PT09PT09PT09PT0KdGhyZWFkcyAgICAgZGVm
YXVsdF9vcHQgW3JlYWRfMU0oTUIvcyldICBkaW9yZWFkX25vbG9ja19vcHQgW3JlYWRfMU0o
TUIvcyldCi0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCjEgICAgICAgICAgIDQzLjY0NTgzMzMzMzMz
MzMgICAgICAgICAgICAgNDMuNjc3MDgzMzMzMzMzMyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKOCAgICAgICAgICAgNDguMTE3ODM4NTQxNjY2NyAgICAgICAgICAgICA0
OS4yNzE4MDk4OTU4MzMzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoyNCAg
ICAgICAgICA1MC41NzAzMTI1ICAgICAgICAgICAgICAgICAgIDUzLjc4OTA2MjUKCgpydygx
TSkgLSB3cml0ZSAocHN5bmMpCj09PT09PT09PT09PT09CnRocmVhZHMgICAgIGRlZmF1bHRf
b3B0IFt3cml0ZV8xTShNQi9zKV0gICBkaW9yZWFkX25vbG9ja19vcHQgW3dyaXRlXzFNKE1C
L3MpCi0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KMSAgICAgICAgICAgNDUuNTA2NTEwNDE2NjY2
NyAgICAgICAgICAgICAgIDQ1LjU2NTQyOTY4NzUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAo4ICAgICAgICAgICA0OS43NDMxNjQwNjI1ICAgICAgICAgICAgICAg
ICAgNTEuMDY5MDEwNDE2NjY2NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CjI0ICAgICAgICAgIDUwLjI0OTM0ODk1ODMzMzMgICAgICAgICAgICAgICA1My4zNDYzNTQx
NjY2NjY3ICAgICAgICAgCgo=
--------------D66429D529101157068B4F61--

