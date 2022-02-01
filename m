Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF44A6072
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Feb 2022 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiBAPrP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Feb 2022 10:47:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47664 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240521AbiBAPrN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Feb 2022 10:47:13 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 211Fl6Ra009557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Feb 2022 10:47:06 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 436AA15C0040; Tue,  1 Feb 2022 10:47:06 -0500 (EST)
Date:   Tue, 1 Feb 2022 10:47:06 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: ext4's dependency on crc32c
Message-ID: <YflV+qAsrKCj8h1U@mit.edu>
References: <73fc221b-400b-a749-4bca-e6854d361a9a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fc221b-400b-a749-4bca-e6854d361a9a@suse.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 01, 2022 at 03:19:54PM +0100, Jan Beulich wrote:
> Hello,
> 
> in 5.16, due to (afaict) adad556efcdd ("crypto: api - Fix built-in
> testing dependency failures") booting a system with cryptmgr.ko not
> (perhaps manually) put in the initrd doesn't work when ext4.ko is
> responsible for / . I've contacted Herbert already after finding
> this issue with btrfs, but in the case of ext4 another aspect plays
> into it: I've observed the problem on a system where ext4.ko is used
> solely to service ext3 partitions (including / ), but aiui crc32c
> isn't used at all in this case. Yet it's the attempt of loading it
> which actually causes the mount (and hence booting) to fail.
> 
> If my understanding is correct, wouldn't it make sense to skip the
> call to crypto_alloc_shash() unless an ext4 superblock is being
> processed?

Sure, there are some subtleties, though.  For example, we would need
to make sure that sbi->s_chksum_driver() is initialized before we
attempt to use it.  That's because an malicious attacker (or syzbot
fuzzer --- is there a difference? :-) could force the file system
feature bits to be set after we decide whether or not to allocate the
crypto handle.  This can happen by having a maliciously corrupted file
system image which sets the file system feature bits as part of the
journal replay, or simply by writing to the superblock after it is
mounted.

	       	       				- Ted
