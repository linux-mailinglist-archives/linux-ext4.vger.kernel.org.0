Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E022747C2
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVRwJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Sep 2020 13:52:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVRwJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Sep 2020 13:52:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MHnTpf016003;
        Tue, 22 Sep 2020 17:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tKp0gjTuUl5FS6UF4LTzDWbYYwdBgqWzuDjG9FaDYQI=;
 b=pKpfT5O9e43T1CDG4mvDweS2YfhawYTRLxnjSBadj1ppjY0ofTnY0b3lIhzsF0mjoNwC
 EFLXmWHxw7Ugph6MWn7HUpev/KsKPKoi+jzXq6NyQ350+BdPwxEtgP77EffylpwwiYSu
 Zel87ftaRQjFZjynqmPJpvFrJuIEcOf/9uaR8zqK+yDPOqYOBtsTP+qh+I/h6Xbcrm/I
 aPQD9DSmHbfB2pliuf1UdfeaGeQDLRPevsV8fiIQOO87gbcvHhV/niltOnPdqxsTpRRo
 DqDQAp8TCDDA2GqyIB1IceORjpfAvghcP3xrgGzCBWJY9dcK6ujeEA8bLTGIXskjGI3d 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33qcptu6ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 17:52:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MHjMVd144198;
        Tue, 22 Sep 2020 17:50:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nuwyrq05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 17:50:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08MHo3WV022388;
        Tue, 22 Sep 2020 17:50:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 10:50:02 -0700
Date:   Tue, 22 Sep 2020 10:50:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v9 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
Message-ID: <20200922175001.GB7948@magnolia>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919005451.3899779-2-harshadshirwadkar@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220139
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 05:54:43PM -0700, Harshad Shirwadkar wrote:
> This patch adds necessary documentation for fast commits.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  Documentation/filesystems/ext4/journal.rst | 66 ++++++++++++++++++++++
>  Documentation/filesystems/journalling.rst  | 28 +++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> index ea613ee701f5..c2e4d010a201 100644
> --- a/Documentation/filesystems/ext4/journal.rst
> +++ b/Documentation/filesystems/ext4/journal.rst
> @@ -28,6 +28,17 @@ metadata are written to disk through the journal. This is slower but
>  safest. If ``data=writeback``, dirty data blocks are not flushed to the
>  disk before the metadata are written to disk through the journal.
>  
> +In case of ``data=ordered`` mode, Ext4 also supports fast commits which
> +help reduce commit latency significantly. The default ``data=ordered``
> +mode works by logging metadata blocks tothe journal. In fast commit

"to the journal"

> +mode, Ext4 only stores the minimal delta needed to recreate the
> +affected metadata in fast commit space that is shared with JBD2.
> +Once the fast commit area fills in or if fast commit is not possible
> +or if JBD2 commit timer goes off, Ext4 performs a traditional full commit.
> +A full commit invalidates all the fast commits that happened before
> +it and thus it makes the fast commit area empty for further fast
> +commits. This feature needs to be enabled at compile time.

And mkfs time too, I would hope?

> +
>  The journal inode is typically inode 8. The first 68 bytes of the
>  journal inode are replicated in the ext4 superblock. The journal itself
>  is normal (but hidden) file within the filesystem. The file usually
> @@ -609,3 +620,58 @@ bytes long (but uses a full block):
>       - h\_commit\_nsec
>       - Nanoseconds component of the above timestamp.
>  
> +Fast commits
> +~~~~~~~~~~~~
> +
> +Fast commit area is organized as a log of tag tag length values. Each TLV has
> +a ``struct ext4_fc_tl`` in the beginning which stores the tag and the length
> +of the entire field. It is followed by variable length tag specific value.

"The fast commit area is organized as a log of tagged variable-length
values.  Each value begins with a ``struct ext4_fc_tl`` tag that
identifies the type of the value and its length, and is followed by the
value itself." ?

I would've called that struct "ext4_fc_tag" or something, since "tl"
isn't really a word... ah well.

> +Here is the list of supported tags and their meanings:
> +
> +.. list-table::
> +   :widths: 8 20 20 32
> +   :header-rows: 1
> +
> +   * - Tag
> +     - Meaning
> +     - Value struct
> +     - Description
> +   * - EXT4_FC_TAG_HEAD
> +     - Fast commit area header
> +     - ``struct ext4_fc_head``
> +     - Stores the TID of the transaction after which these fast commits should
> +       be applied.

So I guess log recovery is supposed to apply the transaction TID, then
apply these fast commits, and then move on to the next transaction?

--D

> +   * - EXT4_FC_TAG_ADD_RANGE
> +     - Add extent to inode
> +     - ``struct ext4_fc_add_range``
> +     - Stores the inode number and extent to be added in this inode
> +   * - EXT4_FC_TAG_DEL_RANGE
> +     - Remove logical offsets to inode
> +     - ``struct ext4_fc_del_range``
> +     - Stores the inode number and the logical offset range that needs to be
> +       removed
> +   * - EXT4_FC_TAG_CREAT
> +     - Create directory entry for a newly created file
> +     - ``struct ext4_fc_dentry_info``
> +     - Stores the parent inode numer, inode number and directory entry of the
> +       newly created file
> +   * - EXT4_FC_TAG_LINK
> +     - Link a directory entry to an inode
> +     - ``struct ext4_fc_dentry_info``
> +     - Stores the parent inode numer, inode number and directory entry
> +   * - EXT4_FC_TAG_UNLINK
> +     - Unink a directory entry of an inode
> +     - ``struct ext4_fc_dentry_info``
> +     - Stores the parent inode numer, inode number and directory entry
> +
> +   * - EXT4_FC_TAG_PAD
> +     - Padding (unused area)
> +     - None
> +     - Unused bytes in the fast commit area.
> +
> +   * - EXT4_FC_TAG_TAIL
> +     - Mark the end of a fast commit
> +     - ``struct ext4_fc_tail``
> +     - Stores the TID of the commit, CRC of the fast commit of which this tag
> +       represents the end of
> +
> diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
> index 58ce6b395206..a9817220dc9b 100644
> --- a/Documentation/filesystems/journalling.rst
> +++ b/Documentation/filesystems/journalling.rst
> @@ -132,6 +132,34 @@ The opportunities for abuse and DOS attacks with this should be obvious,
>  if you allow unprivileged userspace to trigger codepaths containing
>  these calls.
>  
> +Fast commits
> +~~~~~~~~~~~~
> +
> +JBD2 to also allows you to perform file-system specific delta commits known as
> +fast commits. In order to use fast commits, you first need to call
> +:c:func:`jbd2_fc_init` and tell how many blocks at the end of journal
> +area should be reserved for fast commits. Along with that, you will also need
> +to set following callbacks that perform correspodning work:
> +
> +`journal->j_fc_cleanup_cb`: Cleanup function called after every full commit and
> +fast commit.
> +
> +`journal->j_fc_replay_cb`: Replay function called for replay of fast commit
> +blocks.
> +
> +File system is free to perform fast commits as and when it wants as long as it
> +gets permission from JBD2 to do so by calling the function
> +:c:func:`jbd2_fc_start()`. Once a fast commit is done, the client
> +file  system should tell JBD2 about it by calling :c:func:`jbd2_fc_stop()`.
> +If file system wants JBD2 to perform a full commit immediately after stopping
> +the fast commit it can do so by calling :c:func:`jbd2_fc_stop_do_commit()`.
> +This is useful if fast commit operation fails for some reason and the only way
> +to guarantee consistency is for JBD2 to perform the full traditional commit.
> +
> +JBD2 helper functions to manage fast commit buffers. File system can use
> +:c:func:`jbd2_fc_get_buf()` and :c:func:`jbd2_fc_wait_bufs()` to allocate
> +and wait on IO completion of fast commit buffers.
> +
>  Summary
>  ~~~~~~~
>  
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
