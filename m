Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2422FEBA
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jul 2020 03:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG1BIe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 21:08:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38362 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgG1BId (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jul 2020 21:08:33 -0400
X-IronPort-AV: E=Sophos;i="5.75,404,1589212800"; 
   d="scan'208";a="96961203"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jul 2020 09:08:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 723C04CE506E;
        Tue, 28 Jul 2020 09:08:29 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Jul 2020 09:08:26 +0800
Message-ID: <5F1F7A82.6020005@cn.fujitsu.com>
Date:   Tue, 28 Jul 2020 09:08:18 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>, <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] chattr/lsattr: Support dax attribute
References: <20200727092901.2728-1-yangx.jy@cn.fujitsu.com> <20200727153748.GA1138@sol.localdomain>
In-Reply-To: <20200727153748.GA1138@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 723C04CE506E.ABD08
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eric,

Thanks for your review.

On 2020/7/27 23:37, Eric Biggers wrote:
> On Mon, Jul 27, 2020 at 05:29:01PM +0800, Xiao Yang wrote:
>> Use the letter 'x' to set/get dax attribute on a directory/file.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   lib/e2p/pf.c         |  1 +
>>   lib/ext2fs/ext2_fs.h |  1 +
>>   misc/chattr.1.in     | 10 ++++++++--
>>   misc/chattr.c        |  3 ++-
>>   4 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
>> index 0c6998c4..e59cccff 100644
>> --- a/lib/e2p/pf.c
>> +++ b/lib/e2p/pf.c
>> @@ -44,6 +44,7 @@ static struct flags_name flags_array[] = {
>>   	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
>>   	{ EXT4_EXTENTS_FL, "e", "Extents" },
>>   	{ FS_NOCOW_FL, "C", "No_COW" },
>> +	{ FS_DAX_FL, "x", "Dax" },
>>   	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
>>   	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
>>   	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
>> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
>> index 6c20ea77..b5e2e42a 100644
>> --- a/lib/ext2fs/ext2_fs.h
>> +++ b/lib/ext2fs/ext2_fs.h
>> @@ -334,6 +334,7 @@ struct ext2_dx_tail {
>>   #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>>   /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
>>   #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
>> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
>>   #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a snapshot */
>>   #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being deleted */
>>   #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot shrink has completed */
> How about putting the values in order?

Sure, I will put the values in order.

>> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
>> index ff2fcf00..b27c8e1f 100644
>> --- a/misc/chattr.1.in
>> +++ b/misc/chattr.1.in
>> @@ -23,7 +23,7 @@ chattr \- change file attributes on a Linux file system
>>   .B chattr
>>   changes the file attributes on a Linux file system.
>>   .PP
>> -The format of a symbolic mode is +-=[aAcCdDeFijPsStTu].
>> +The format of a symbolic mode is +-=[aAcCdDeFijPsStTux].
>>   .PP
>>   The operator '+' causes the selected attributes to be added to the
>>   existing attributes of the files; '-' causes them to be removed; and '='
>> @@ -45,7 +45,8 @@ secure deletion (s),
>>   synchronous updates (S),
>>   no tail-merging (t),
>>   top of directory hierarchy (T),
>> -and undeletable (u).
>> +undeletable (u),
>> +and direct access for files (x).
> There's another part that needs to be updated to add "x":
>
> "The letters 'aAcCdDeFijPsStTu' select the new attributes for the files:"
Good catch. :-)

Thanks,
Xiao Yang
>
> .
>



