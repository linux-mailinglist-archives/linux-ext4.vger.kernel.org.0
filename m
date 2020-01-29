Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F1314CDD4
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2020 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA2Pzh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jan 2020 10:55:37 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:48395 "EHLO
        MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgA2Pzh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jan 2020 10:55:37 -0500
X-Greylist: delayed 1383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 10:55:36 EST
Received: by mail.13thfloor.at (Postfix, from userid 1001)
        id 86DEB16311; Wed, 29 Jan 2020 16:32:29 +0100 (CET)
Date:   Wed, 29 Jan 2020 16:32:29 +0100
From:   Herbert Poetzl <herbert@13thfloor.at>
To:     linux-ext4@vger.kernel.org
Subject: comm setfattr: corrupted xattr entries on 'clean' filesystem
Message-ID: <20200129153229.GB29184@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Not sure this is the best place for this, but it was
suggest on #linuxfs to report the problem here ...

I have an (older) ext3 filesystem where 'some' files
are unable to accept any extended attributes (xattrs).

 # setfattr -n user.x -v y some-file

... results in ...

 setfattr: some-file: Structure needs cleaning

... and the kernel reports ...

kernel: EXT4-fs error (device md2): ext4_xattr_set_entry:1607: inode #2084096: comm setfattr: corrupted xattr entries

... kernel is not the latest (4.19.84), but e2fsck is ...

e2fsck 1.45.5 (07-Jan-2020)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/md2: 6594874/9538640 files (2.7% non-contiguous), 3887814750/3907018432 blocks

Any suggestions how to 'clean my structures' would
be appreciated!

Thanks in advance,
Herbert

