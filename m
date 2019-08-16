Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950D68F83E
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2019 03:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfHPBAf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 21:00:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHPBAf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Aug 2019 21:00:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G0wfRc018197;
        Fri, 16 Aug 2019 01:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=LGdoQSew9bKQooMOqG7q83hx4BsMJD0DTzfUWaN5FTM=;
 b=LmtGW/IlRylCzzPgpR9KqmAaSQk9wVm/Asf89vMkqCJZ5qMFhmPRBbkNsAslsQAei5KZ
 +c0d6bHxglQu3ZCntAxt/FXx3riL3oP2lH7JkMnkf+BNW/3wDn6kStPJsvQPymnqStYo
 cXn+RywC5pEtLi2E4PsMwmCMao9PkNg0dCJOISl3oWJujPAFjK1YCHrZYhf05S1+cLqs
 12dhSWIALa5p9WPho/ltpUyM1rwBY/rrPmzqS2YgCuS1JdJ7gRncAxO6SZklpIfD/sXw
 pDYhDYjh96VYGSoDkIhKPGF9TDFVssYtuakJO3/+u3JAsWZgxEKeR0xDuXsdEmDxYl/h Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u9pjqwm6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 01:00:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G0wCd3176344;
        Fri, 16 Aug 2019 01:00:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2udgqfj9uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 01:00:31 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7G10U0u028677;
        Fri, 16 Aug 2019 01:00:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 18:00:30 -0700
Date:   Thu, 15 Aug 2019 18:00:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 12/12] docs: Add fast commit documentation
Message-ID: <20190816010029.GA15175@magnolia>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-13-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809034552.148629-13-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160007
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 08, 2019 at 08:45:52PM -0700, Harshad Shirwadkar wrote:
> This patch adds necessary documentation to
> Documentation/filesystems/journalling.rst and
> Documentation/filesystems/ext4/journal.rst.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  Documentation/filesystems/ext4/journal.rst | 96 ++++++++++++++++++++--
>  Documentation/filesystems/journalling.rst  | 15 ++++
>  2 files changed, 105 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> index ea613ee701f5..d6e4a698e208 100644
> --- a/Documentation/filesystems/ext4/journal.rst
> +++ b/Documentation/filesystems/ext4/journal.rst
> @@ -29,10 +29,14 @@ safest. If ``data=writeback``, dirty data blocks are not flushed to the
>  disk before the metadata are written to disk through the journal.
>  
>  The journal inode is typically inode 8. The first 68 bytes of the
> -journal inode are replicated in the ext4 superblock. The journal itself
> -is normal (but hidden) file within the filesystem. The file usually
> -consumes an entire block group, though mke2fs tries to put it in the
> -middle of the disk.
> +journal inode are replicated in the ext4 superblock. The journal
> +itself is normal (but hidden) file within the filesystem. The file
> +usually consumes an entire block group, though mke2fs tries to put it
> +in the middle of the disk. Last 128 blocks in the journal are reserved
> +for fast commits. Fast commits store metadata changes to inodes in an
> +incremental fashion. A fast commit is valid only if there is no full
> +commit after that particular fast commit. That makes fast commit space
> +reusable after every full commit.
>  
>  All fields in jbd2 are written to disk in big-endian order. This is the
>  opposite of ext4.
> @@ -48,16 +52,18 @@ Layout
>  Generally speaking, the journal has this format:
>  
>  .. list-table::
> -   :widths: 16 48 16
> +   :widths: 16 48 16 18
>     :header-rows: 1
>  
>     * - Superblock
>       - descriptor\_block (data\_blocks or revocation\_block) [more data or
>         revocations] commmit\_block
>       - [more transactions...]
> +     - [Fast commits...]
>     * - 
>       - One transaction
>       -
> +     -
>  
>  Notice that a transaction begins with either a descriptor and some data,
>  or a block revocation list. A finished transaction always ends with a
> @@ -76,7 +82,7 @@ The journal superblock will be in the next full block after the
>  superblock.
>  
>  .. list-table::
> -   :widths: 12 12 12 32 12
> +   :widths: 12 12 12 32 12 12
>     :header-rows: 1
>  
>     * - 1024 bytes of padding
> @@ -85,11 +91,13 @@ superblock.
>       - descriptor\_block (data\_blocks or revocation\_block) [more data or
>         revocations] commmit\_block
>       - [more transactions...]
> +     - [Fast commits...]
>     * - 
>       -
>       -
>       - One transaction
>       -
> +     -
>  
>  Block Header
>  ~~~~~~~~~~~~
> @@ -609,3 +617,79 @@ bytes long (but uses a full block):
>       - h\_commit\_nsec
>       - Nanoseconds component of the above timestamp.
>  
> +Fast Commit Block
> +~~~~~~~~~~~~~~~~~
> +
> +The fast commit block indicates an append to the last commit block
> +that was written to the journal. One fast commit block records updates
> +to one inode. So, typically you would find as many fast commit blocks
> +as the number of inodes that got changed since the last commit. A fast
> +commit block is valid only if there is no commit block present with
> +transaction ID greater than that of the fast commit block. If such a
> +block a present, then there is no need to replay the fast commit
> +block.
> +
> +Multiple fast commit blocks are a part of one sub-transaction. To
> +indicate the last block in a fast commit transaction, fc_flags field
> +in the last block in every subtransaction is marked with "LAST" (0x1)
> +flag. A subtransaction is valid only if all the following conditions
> +are met:
> +
> +1) SUBTID of all blocks is either equal to or greater than SUBTID of
> +   the previous fast commit block.
> +2) For every sub-transaction, last block is marked with LAST flag.
> +3) There are no invalid blocks in between.
> +
> +.. list-table::
> +   :widths: 8 8 24 40
> +   :header-rows: 1
> +
> +   * - Offset
> +     - Type
> +     - Name
> +     - Descriptor
> +   * - 0x0
> +     - journal\_header\_s
> +     - (open coded)
> +     - Common block header.
> +   * - 0xC
> +     - \_\_le32
> +     - fc\_magic
> +     - Magic value which should be set to 0xE2540090. This identifies
> +       that this block is a fast commit block.
> +   * - 0x10
> +     - \_\_le32
> +     - fc\_subtid
> +     - Sub-transaction ID for this commit block
> +   * - 0x14
> +     - \_\_u8
> +     - fc\_features
> +     - Features used by this fast commit block.
> +   * - 0x15
> +     - \_\_u8
> +     - fc_flags
> +     - Flags. (0x1(Last) - Indicates that this is the last block in sub-transaction)
> +   * - 0x16
> +     - \_\_le16
> +     - fc_num_tlvs
> +     - Number of TLVs contained in this fast commit block
> +   * - 0x18
> +     - \_\_le32
> +     - \_\_fc\_len
> +     - Length of the fast commit block in terms of number of blocks
> +   * - 0x2c
> +     - \_\_le32
> +     - fc\_ino
> +     - Inode number of the inode that will be recovered using this fast commit
> +   * - 0x30
> +     - struct ext4\_inode
> +     - inode
> +     - On-disk copy of the inode at the commit time
> +   * - 0x34
> +     - struct ext4\_fc\_tl
> +     - Array of struct ext4\_fc\_tl
> +     - The actual delta with the last commit. Starting at this offset,
> +       there is an array of TLVs that indicates which all extents
> +       should be present in the corresponding inode. Currently, the
> +       only tag that is supported is EXT4\_FC\_TAG\_EXT. That tag
> +       indicates that the corresponding value is an extent.

This is a good start, but what's the structure of struct ext4_fc_tl ?
It's written to disk, it should be here too.  Looks like it's mostly
just an array of ondisk extent structures?

So if I read this right, this first fastcommit tag type seems to be an
inode core and an array of extents which ... I guess are the extents
that were allocated and mapped into the file?  So therefore journal
replay of this metadata update becomes a simple matter of logging the
new inode core, adding the associated fc extent records to the extent
map, and marking the corresponding parts of the block bitmap in use?

I'm wondering why these fast commits aren't written inline with the
regular jbd2 transaction block stream?  i.e.

[descriptors][blocks][commit][fastcommit][fastcommit][descriptor...]

That way jbd2 replay just adds a case for a journal block with h_magic
== JBD2_FC_MAGIC where it checkpoints whatever it had staged at that
point, throws the fast commit block up to ext4 to do whatever, and then
continues on replaying regular transactions?  I get this feeling like
fastcommit is a journal that runs inside of/alongside jbd2 and wonder
why not just integrate it better with jbd2?

> diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
> index 58ce6b395206..2e0d550b546c 100644
> --- a/Documentation/filesystems/journalling.rst
> +++ b/Documentation/filesystems/journalling.rst
> @@ -115,6 +115,21 @@ called after each transaction commit. You can also use
>  ``transaction->t_private_list`` for attaching entries to a transaction
>  that need processing when the transaction commits.
>  
> +JBD2 also allows client file systems to implement file system specific
> +commits which are called as ``fast commits``. File systems that wish
> +to use this feature should first set
> +``journal->j_fc_commit_callback``. That function is called before
> +performing a commit. File system can call :c:func:`jbd2_map_fc_buf()`
> +to get buffers reserved for fast commits. If file system returns 0,
> +JBD2 assumes that file system performed a fast commit and it backs off
> +from performing a commit. Otherwise, JBD2 falls back to normal full

Huh.  Ok, so the caller I guess grabs fastcommit blocks, writes the
intent to the fc block, and pushes it to disk, after which we can return
to userspace.  Some time later jbd2 gets around to committing things so
it calls back with ->j_fc_commit_callback at which point we say "Oh! I
already wrote that to disk as a fastcommit, so return 0" and jbd2
shrugs and moves on to the next transaction?

--D

> +commit. After performing either a fast or a full commit, JBD2 calls
> +``journal->j_fc_cleanup_cb`` to allow file systems to perform cleanups
> +for their internal fast commit related data structures. At the replay
> +time, JBD2 passes each and every fast commit block to the file system
> +via ``journal->j_fc_replay_cb``. Ext4 effectively uses this fast
> +commit mechanism to improve journal commit performance.
> +
>  JBD2 also provides a way to block all transaction updates via
>  :c:func:`jbd2_journal_lock_updates()` /
>  :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants a
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 
