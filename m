Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3D27C9C6
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbgI2MNq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Sep 2020 08:13:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgI2Lh3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 29 Sep 2020 07:37:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71063B208;
        Tue, 29 Sep 2020 11:37:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 238411E12E9; Tue, 29 Sep 2020 13:37:27 +0200 (CEST)
Date:   Tue, 29 Sep 2020 13:37:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Subject: Re: [RFC PATCH v4 0/4] ext4/jbd2: data=journal: write-protect pages
 on transaction commit
Message-ID: <20200929113727.GK10896@quack2.suse.cz>
References: <20200928194103.244692-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928194103.244692-1-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 28-09-20 16:40:59, Mauricio Faria de Oliveira wrote:
> Hey Jan,
> 
> This series implements your suggestions for the RFC PATCH v3 set [1].
> 
> That addressed the issue you confirmed with block_page_mkwrite() [2].
> There's no "JBD2: Spotted dirty metadata buffer" message in over 72h
> runs across 3 VMs (it used to happen within a few hours.) *Thanks!*
> 
> I added Reviewed-by: tags for the patches/changes you mentioned.
> The only changes from v3 are patch 3 which is new, and contains
> the 2 fixes to ext4_page_mkwrite(); and patch 4 changed 'struct
> writeback_control.nr_to_write' from ~0ULL to LONG_MAX, since it
> is signed long (~0ULL overflows to -1; kudos, kernel test robot!)
> 
> It looks almost good on fstests: zero regressions on data=ordered,
> and two apparently flaky tests data=journal (generic/347 _passed_
> 1/6 times with the patch, and generic/547 failed 1/6 times.)

Cool. Neither of these tests has anything to do with mmap. The first test
checks what happens when thin provisioned storage runs out of space (and
that fs remains consistent), the second tests that fsync flushed properly
all data and that it can be seen after a crash. So I'm reasonably confident
that it isn't caused by your patches. It still might be a bug in
data=journal implementation though but that would be something for another
patch series :).

I'll have a look at the remaining patches.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
