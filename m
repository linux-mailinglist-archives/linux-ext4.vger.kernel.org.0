Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2631355A2
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgAIJVv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 04:21:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729429AbgAIJVu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jan 2020 04:21:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0099Bw9I065652
        for <linux-ext4@vger.kernel.org>; Thu, 9 Jan 2020 04:21:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xdvtaheb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jan 2020 04:21:49 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 9 Jan 2020 09:21:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 09:21:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0099LjTE57475094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 09:21:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC31BA405C;
        Thu,  9 Jan 2020 09:21:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E90E2A4062;
        Thu,  9 Jan 2020 09:21:42 +0000 (GMT)
Received: from [9.199.159.43] (unknown [9.199.159.43])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 09:21:42 +0000 (GMT)
Subject: Re: Discussion: is it time to remove dioread_nolock?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
References: <20191226153118.GA17237@mit.edu>
 <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
 <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
 <20200107004338.GB125832@mit.edu> <20200107082212.GA25547@quack2.suse.cz>
 <20200107171109.GB3619@mit.edu> <20200107172236.GJ25547@quack2.suse.cz>
 <20200108104520.3BC4A4203F@d06av24.portsmouth.uk.ibm.com>
 <20200108174259.GD263696@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 9 Jan 2020 14:51:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200108174259.GD263696@mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010909-0008-0000-0000-00000347DC63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010909-0009-0000-0000-00004A682285
Message-Id: <20200109092142.E90E2A4062@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001090081
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 1/8/20 11:12 PM, Theodore Y. Ts'o wrote:
> On Wed, Jan 08, 2020 at 04:15:13PM +0530, Ritesh Harjani wrote:
>> Hello Ted/Jan,
>>
>> On 1/7/20 10:52 PM, Jan Kara wrote:
>>> On Tue 07-01-20 12:11:09, Theodore Y. Ts'o wrote:
>>>> Hmm..... There's actually an even more radical option we could use,
>>>> given that Ritesh has made dioread_nolock work on block sizes < page
>>>> size.  We could make dioread_nolock the default, until we can revamp
>>>> ext4_writepages() to write the data blocks first....
>>
>> Agreed. I guess it should be a straight forward change to make.
>> It should be just removing test_opt(inode->i_sb, DIOREAD_NOLOCK) condition
>> from ext4_should_dioread_nolock().
> 
> Actually, it's simpler than that.  In fs/ext4/super.c, around line
> 3730, after the comment:
> 
> 	/* Set defaults before we parse the mount options */
> 
> Just add:
> 
>       set_opt(sb, DIOREAD_NOLOCK);

Yes, silly me.


> 
> This will allow system administrators to revert back to the original
> method using the someone confusingly named mount option,
> "dioread_lock".  (Maybe we can add a alias for that mount option so
> it's less confusing).
> 
>>> Yes, that's a good point. And I'm not opposed to that if it makes the life
>>> simpler. But I'd like to see some performance numbers showing how much is
>>> writeback using unwritten extents slower so that we don't introduce too big
>>> regression with this...
>>>
>>
>> Yes, let me try to get some performance numbers with dioread_nolock as
>> the default option for buffered write on my setup.
> 
> I started running some performance runs last night, and the
> interesting thing that I found was that fs_mark actually *improved*
> with dioread_nolock (with fsync enabled).  That may be an example of
> where fixing the commit latency caused by writeback can actually show
> up in a measurable way with benchmarks.
> 
> Dbench was slightly impacted; I didn't see any real differences with
> compilebench or postmark.  dioread_nolock did improve fio with
> sequential reads; which is interesting, since I would have expected

IIUC, this Seq. read numbers are with --direct=1 & bs=2MB & 
ioengine=libaio, correct?
So essentially it will do a DIO AIO sequential read.

Yes, it *does shows* a big delta in the numbers. I also noticed a higher
deviation between the two runs with dioread_nolock.


> with the inode_lock improvements, there shouldn't have been any
> difference.  So that may be a bit of wierdness that we should try to
> understand.

So inode_lock patches gives improvement in mixed read/write workload
where inode exclusive locking was causing the bottleneck earlier.


In this run, was encryption or fsverity enabled?
If yes then in that case I see that ext4_dio_supported() will return
false and it will fallback to bufferedRead.
Though with that also can't explain the delta with only enabling
dioread_nolock.


> 
> See the attached tar file; open ext4-modes/index.html in a browser to
> see the pretty graphs.  The raw numbers are in ext4/composite.xml.

The graphs and overview looks really good. I will also check about PTS
sometime. Will be good to capture such reports.


ritesh

