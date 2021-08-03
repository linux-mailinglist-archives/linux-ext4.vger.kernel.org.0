Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0573DF365
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhHCRBl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 13:01:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39513 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237507AbhHCQ5w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 12:57:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 173GvaBt005122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 12:57:37 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D4A0015C37C1; Tue,  3 Aug 2021 12:57:36 -0400 (EDT)
Date:   Tue, 3 Aug 2021 12:57:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] libext2fs: Support for orphan file feature
Message-ID: <YQl1gGwVSB5+IMCW@mit.edu>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210712154315.9606-5-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 12, 2021 at 05:43:10PM +0200, Jan Kara wrote:
> @@ -825,6 +826,7 @@ struct ext2_super_block {
>  #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
>  #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
>  #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
> +#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x0080
>  #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
>  #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200

(This isn't a full review of the patch, but just a quick feedback of
what I've noticed so far.)

Since Andreas has requested that we not get rid of the
RO_COMPAT_SNAPSHOT, I'm using 0x0400 for
EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT in my testing.

I also noted a number of new GCC warnings when running "make gcc-wall"
on lib/ext2fs after applying this commit.

					- Ted

/usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/orphan.c: In function ‘ext2fs_do_orphan_file_block_csum’:
/usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/orphan.c:58:30: warning: pointer targets in passing argument 2 of ‘ext2fs_crc32c_le’ differ in signedness [-Wpointer-sign]
   58 |  crc = ext2fs_crc32c_le(crc, buf, inodes_per_ob * sizeof(__u32));
      |                              ^~~
      |                              |
      |                              char *
In file included from /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/ext2fsP.h:16,
                 from /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/orphan.c:16:
/usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/ext2fs.h:1075:63: note: expected ‘const unsigned char *’ but argument is of type ‘char *’
 1075 | extern __u32 ext2fs_crc32c_le(__u32 crc, unsigned char const *p, size_t len);
      |                                          ~~~~~~~~~~~~~~~~~~~~~^
/usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/orphan.c: In function ‘ext2fs_do_orphan_file_block_csum’:
/usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/orphan.c:58:30: warning: pointer targets in passing argument 2 of ‘ext2fs_crc32c_le’ differ in signedness [-Wpointer-sign]
   58 |  crc = ext2fs_crc32c_le(crc, buf, inodes_per_ob * sizeof(__u32));
      |                              ^~~
      |                              |
      |                              char *
In file included from /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/ext2fsP.h:16,
                 from /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/orphan.c:16:
/usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/ext2fs.h:1075:63: note: expected ‘const unsigned char *’ but argument is of type ‘char *’
 1075 | extern __u32 ext2fs_crc32c_le(__u32 crc, unsigned char const *p, size_t len);
      |                                          ~~~~~~~~~~~~~~~~~~~~~^
make[1]: Leaving directory '/build/e2fsprogs/lib/ext2fs'


