Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A159194226
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Mar 2020 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCZO5Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Mar 2020 10:57:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59966 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727895AbgCZO5Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Mar 2020 10:57:16 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02QEvBVc002301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 10:57:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 46A4C420EBA; Thu, 26 Mar 2020 10:57:11 -0400 (EDT)
Date:   Thu, 26 Mar 2020 10:57:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH] ext4: do not commit super on read-only bdev
Message-ID: <20200326145711.GS53396@mit.edu>
References: <4b6e774d-cc00-3469-7abb-108eb151071a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6e774d-cc00-3469-7abb-108eb151071a@sandeen.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 18, 2020 at 02:19:38PM -0500, Eric Sandeen wrote:
> From: Eric Sandeen <sandeen@redhat.com>
> 
> Under some circumstances we may encounter a filesystem error on a
> read-only block device, and if we try to save the error info to the
> superblock and commit it, we'll wind up with a noisy error and
> backtrace, i.e.:
> 
> [ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
> ------------[ cut here ]------------
> generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
> WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 generic_make_request_checks+0x6b4/0x7d0
> ...
> 
> To avoid this, commit the error info in the superblock only if the
> block device is writable.
> 
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Thanks, applied.

					- Ted
