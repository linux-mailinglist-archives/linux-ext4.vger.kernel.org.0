Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCB243228
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 03:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMBmh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 21:42:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6594 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbgHMBmh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 21:42:37 -0400
X-IronPort-AV: E=Sophos;i="5.76,306,1592841600"; 
   d="scan'208";a="98048930"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Aug 2020 09:42:33 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id CDF204CE34E5;
        Thu, 13 Aug 2020 09:42:27 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 13 Aug 2020 09:42:29 +0800
Message-ID: <5F349A82.5080007@cn.fujitsu.com>
Date:   Thu, 13 Aug 2020 09:42:26 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Andreas Dilger <adilger@dilger.ca>
CC:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com> <9FB1F4E5-7B7C-4E09-A415-3C5C888B321F@dilger.ca>
In-Reply-To: <9FB1F4E5-7B7C-4E09-A415-3C5C888B321F@dilger.ca>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: CDF204CE34E5.AD72D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/8/13 7:29, Andreas Dilger wrote:
> On Jul 27, 2020, at 11:33 PM, Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>> Use the letter 'x' to set/get dax attribute on a directory/file.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> One minor nit below, but otherwise looks OK.
>
> Reviewed-by: Andreas Dilger<adilger@dilger.ca>
>
>> diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
>> index 0c6998c4..e59cccff 100644
>> --- a/lib/e2p/pf.c
>> +++ b/lib/e2p/pf.c
>> @@ -44,6 +44,7 @@ static struct flags_name flags_array[] = {
>> 	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
>> 	{ EXT4_EXTENTS_FL, "e", "Extents" },
>> 	{ FS_NOCOW_FL, "C", "No_COW" },
>> +	{ FS_DAX_FL, "x", "Dax" },
> Should this be "DAX" ?  That is how it is commonly used in the kernel.
Hi Andreas,

Thanks a lot for your review.

Either 'Dax' or 'DAX' is fine to me because it is just the output of 
lsattr -v.
For example, xfs_io shows 'dax' instead of 'DAX':
# xfs_io -c "lsattr -v" file
[dax] file

BTW:
I just used 'Dax' to follow the current format of output(i.e. capitalize 
the first letter).

Do you want me to send v3 patch with the 'DAX'? :-)

Best Regards,
Xiao Yang
>> 	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
>> 	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
>> 	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
>> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
>> index 6c20ea77..88f510a3 100644
>> --- a/lib/ext2fs/ext2_fs.h
>> +++ b/lib/ext2fs/ext2_fs.h
>> @@ -335,6 +335,7 @@ struct ext2_dx_tail {
>> /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
>> #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
>> #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a snapshot */
>> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
>> #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being deleted */
>> #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot shrink has completed */
>> #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data */
>> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
>> index ff2fcf00..5a4928a5 100644
>> --- a/misc/chattr.1.in
>> +++ b/misc/chattr.1.in
>> @@ -23,13 +23,13 @@ chattr \- change file attributes on a Linux file system
>> .B chattr
>> changes the file attributes on a Linux file system.
>> .PP
>> -The format of a symbolic mode is +-=[aAcCdDeFijPsStTu].
>> +The format of a symbolic mode is +-=[aAcCdDeFijPsStTux].
>> .PP
>> The operator '+' causes the selected attributes to be added to the
>> existing attributes of the files; '-' causes them to be removed; and '='
>> causes them to be the only attributes that the files have.
>> .PP
>> -The letters 'aAcCdDeFijPsStTu' select the new attributes for the files:
>> +The letters 'aAcCdDeFijPsStTux' select the new attributes for the files:
>> append only (a),
>> no atime updates (A),
>> compressed (c),
>> @@ -45,7 +45,8 @@ secure deletion (s),
>> synchronous updates (S),
>> no tail-merging (t),
>> top of directory hierarchy (T),
>> -and undeletable (u).
>> +undeletable (u),
>> +and direct access for files (x).
>> .PP
>> The following attributes are read-only, and may be listed by
>> .BR lsattr (1)
>> @@ -210,6 +211,14 @@ saved.  This allows the user to ask for its undeletion.  Note: please
>> make sure to read the bugs and limitations section at the end of this
>> document.
>> .TP
>> +.B x
>> +The 'x' attribute can be set on a directory or file.  If the attribute
>> +is set on an existing directory, it will be inherited by all files and
>> +subdirectories that are subsequently created in the directory.  If an
>> +existing directory has contained some files and subdirectories, modifying
>> +the attribute on the parent directory doesn't change the attributes on
>> +these files and subdirectories.
>> +.TP
>> .B V
>> A file with the 'V' attribute set has fs-verity enabled.  It cannot be
>> written to, and the filesystem will automatically verify all data read
>> diff --git a/misc/chattr.c b/misc/chattr.c
>> index a5d60170..c0337f86 100644
>> --- a/misc/chattr.c
>> +++ b/misc/chattr.c
>> @@ -86,7 +86,7 @@ static unsigned long sf;
>> static void usage(void)
>> {
>> 	fprintf(stderr,
>> -		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuF] [-v version] files...\n"),
>> +		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuFx] [-v version] files...\n"),
>> 		program_name);
>> 	exit(1);
>> }
>> @@ -112,6 +112,7 @@ static const struct flags_char flags_array[] = {
>> 	{ EXT2_NOTAIL_FL, 't' },
>> 	{ EXT2_TOPDIR_FL, 'T' },
>> 	{ FS_NOCOW_FL, 'C' },
>> +	{ FS_DAX_FL, 'x' },
>> 	{ EXT4_CASEFOLD_FL, 'F' },
>> 	{ 0, 0 }
>> };
>> --
>> 2.21.0
>>
>>
>>
>
> Cheers, Andreas
>
>
>
>
>



