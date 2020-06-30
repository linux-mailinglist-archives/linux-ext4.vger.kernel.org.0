Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEB20F3C8
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jun 2020 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgF3Lse (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Jun 2020 07:48:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbgF3Lse (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Jun 2020 07:48:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECEA7B5A9;
        Tue, 30 Jun 2020 11:48:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BF4591E12ED; Tue, 30 Jun 2020 13:48:32 +0200 (CEST)
Date:   Tue, 30 Jun 2020 13:48:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Costa Sapuntzakis <costa@purestorage.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [BUG] invalid superblock checksum possibly due to race
Message-ID: <20200630114832.GA16372@quack2.suse.cz>
References: <CAABuPhaMHu+mmHbVKGt2L0tcE2-EMyd5VWcok7kAfJY3DQ=-vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABuPhaMHu+mmHbVKGt2L0tcE2-EMyd5VWcok7kAfJY3DQ=-vw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Wed 24-06-20 16:56:18, Costa Sapuntzakis wrote:
> Our workload: taking snapshots repeatedly of an active ext4 filesystem
> (vdbench fwiw). e2fsck discovered a snapshot that had a corrupted
> superblock after journal replay. Diffing the corrupted superblock to
> the superblock before journal replay revealed that only s_last_orphan
> and the checksum had changed.
> 
> The following race could explain it:
> 
> Thread 1 (T1): ext4_orphan_del -> update s_last_orphan to value A ->
> ext4_handle_dirty_super -> ext4_superblock_csum_set -- PAUSE right
> before setting es->s_checksum
> 
> T2: ext4_orphan_del -> update s_last_orphan to value B ->
> ext4_handle_dirty_super -> ext4_superblock_csum_set runs to completion
> 
> T1: Resume and assign es->s_checksum
> 
> Is there higher level synchronization going on that makes this race benign?

Thanks for report and the analysis. What you describe indeed seems
possible.

> If not, a spinlock around the calculation and assignment should fix it.

Yes, probably ext4_superblock_csum_set() should use

lock_buffer(EXT4_SB(sb)->s_sbh)

to synchronize updating of superblock checksum. Will you send a patch?

> The spinlock still has the race where s_last_orphan is being updated
> while the checksum is calculated. But the last thread to set
> s_last_orphan will also eventually try to recalculate the checksum and
> set it right (though it's possible some other thread will do it for
> it). And I'm guessing/hoping jbd2 won't flush the superblock to the
> journal and close a transaction until the references from
> journal_get_write_access drain. The checksum is recalculated before
> the get_write_access reference is dropped.

Yes, jbd2 layer will make sure that inconsistent block contents will not
make it to disk in this case.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
