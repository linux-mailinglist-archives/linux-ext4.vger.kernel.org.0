Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3516A067
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBXIuI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 03:50:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:58586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgBXIuI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Feb 2020 03:50:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E6F7ADD9;
        Mon, 24 Feb 2020 08:50:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C76371E0E33; Mon, 24 Feb 2020 09:50:06 +0100 (CET)
Date:   Mon, 24 Feb 2020 09:50:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, wangyan <wangyan122@huawei.com>,
        jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        stable@vger.kernel.org, piaojun <piaojun@huawei.com>
Subject: Re: [PATCH] jbd2: fix ocfs2 corrupt when clearing block group bits
Message-ID: <20200224085006.GA27857@quack2.suse.cz>
References: <f72a623f-b3f1-381a-d91d-d22a1c83a336@huawei.com>
 <20200221091808.GA27165@quack2.suse.cz>
 <7f839e10-90d6-c9e7-9ff9-5c395513cd13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f839e10-90d6-c9e7-9ff9-5c395513cd13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Fri 21-02-20 22:53:13, yangerkun wrote:
> Thanks for the patch! And according to the describes, I'd wonder does there
> some scenes exits in ext4 can trigger the similar bug?

Yes, I suppose ext4 could trigger a similar bug in principle.

								Honza

> On 2020/2/21 17:18, Jan Kara wrote:
> > On Thu 20-02-20 21:46:14, wangyan wrote:
> > > I found a NULL pointer dereference in ocfs2_block_group_clear_bits().
> > > The running environment:
> > > 	kernel version: 4.19
> > > 	A cluster with two nodes, 5 luns mounted on two nodes, and do some
> > > 	file operations like dd/fallocate/truncate/rm on every lun with storage
> > > 	network disconnection.
> > > 
> > > The fallocate operation on dm-23-45 caused an null pointer dereference.
> > > 
> > > The information of NULL pointer dereference as follows:
> > > 	[577992.878282] JBD2: Error -5 detected when updating journal superblock for dm-23-45.
> > > 	[577992.878290] Aborting journal on device dm-23-45.
> > > 	...
> > > 	[577992.890778] JBD2: Error -5 detected when updating journal superblock for dm-24-46.
> > > 	[577992.890908] __journal_remove_journal_head: freeing b_committed_data
> > > 	[577992.890916] (fallocate,88392,52):ocfs2_extend_trans:474 ERROR: status = -30
> > > 	[577992.890918] __journal_remove_journal_head: freeing b_committed_data
> > > 	[577992.890920] (fallocate,88392,52):ocfs2_rotate_tree_right:2500 ERROR: status = -30
> > > 	[577992.890922] __journal_remove_journal_head: freeing b_committed_data
> > > 	[577992.890924] (fallocate,88392,52):ocfs2_do_insert_extent:4382 ERROR: status = -30
> > > 	[577992.890928] (fallocate,88392,52):ocfs2_insert_extent:4842 ERROR: status = -30
> > > 	[577992.890928] __journal_remove_journal_head: freeing b_committed_data
> > > 	[577992.890930] (fallocate,88392,52):ocfs2_add_clusters_in_btree:4947 ERROR: status = -30
> > > 	[577992.890933] __journal_remove_journal_head: freeing b_committed_data
> > > 	[577992.890939] __journal_remove_journal_head: freeing b_committed_data
> > > 	[577992.890949] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> > > 	[577992.890950] Mem abort info:
> > > 	[577992.890951]   ESR = 0x96000004
> > > 	[577992.890952]   Exception class = DABT (current EL), IL = 32 bits
> > > 	[577992.890952]   SET = 0, FnV = 0
> > > 	[577992.890953]   EA = 0, S1PTW = 0
> > > 	[577992.890954] Data abort info:
> > > 	[577992.890955]   ISV = 0, ISS = 0x00000004
> > > 	[577992.890956]   CM = 0, WnR = 0
> > > 	[577992.890958] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000f8da07a9
> > > 	[577992.890960] [0000000000000020] pgd=0000000000000000
> > > 	[577992.890964] Internal error: Oops: 96000004 [#1] SMP
> > > 	[577992.890965] Process fallocate (pid: 88392, stack limit = 0x00000000013db2fd)
> > > 	[577992.890968] CPU: 52 PID: 88392 Comm: fallocate Kdump: loaded Tainted: G        W  OE     4.19.36 #1
> > > 	[577992.890969] Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 0.98 08/25/2019
> > > 	[577992.890971] pstate: 60400009 (nZCv daif +PAN -UAO)
> > > 	[577992.891054] pc : _ocfs2_free_suballoc_bits+0x63c/0x968 [ocfs2]
> > > 	[577992.891082] lr : _ocfs2_free_suballoc_bits+0x618/0x968 [ocfs2]
> > > 	[577992.891084] sp : ffff0000c8e2b810
> > > 	[577992.891085] x29: ffff0000c8e2b820 x28: 0000000000000000
> > > 	[577992.891087] x27: 00000000000006f3 x26: ffffa07957b02e70
> > > 	[577992.891089] x25: ffff807c59d50000 x24: 00000000000006f2
> > > 	[577992.891091] x23: 0000000000000001 x22: ffff807bd39abc30
> > > 	[577992.891093] x21: ffff0000811d9000 x20: ffffa07535d6a000
> > > 	[577992.891097] x19: ffff000001681638 x18: ffffffffffffffff
> > > 	[577992.891098] x17: 0000000000000000 x16: ffff000080a03df0
> > > 	[577992.891100] x15: ffff0000811d9708 x14: 203d207375746174
> > > 	[577992.891101] x13: 73203a524f525245 x12: 20373439343a6565
> > > 	[577992.891103] x11: 0000000000000038 x10: 0101010101010101
> > > 	[577992.891106] x9 : ffffa07c68a85d70 x8 : 7f7f7f7f7f7f7f7f
> > > 	[577992.891109] x7 : 0000000000000000 x6 : 0000000000000080
> > > 	[577992.891110] x5 : 0000000000000000 x4 : 0000000000000002
> > > 	[577992.891112] x3 : ffff000001713390 x2 : 2ff90f88b1c22f00
> > > 	[577992.891114] x1 : ffff807bd39abc30 x0 : 0000000000000000
> > > 	[577992.891116] Call trace:
> > > 	[577992.891139]  _ocfs2_free_suballoc_bits+0x63c/0x968 [ocfs2]
> > > 	[577992.891162]  _ocfs2_free_clusters+0x100/0x290 [ocfs2]
> > > 	[577992.891185]  ocfs2_free_clusters+0x50/0x68 [ocfs2]
> > > 	[577992.891206]  ocfs2_add_clusters_in_btree+0x198/0x5e0 [ocfs2]
> > > 	[577992.891227]  ocfs2_add_inode_data+0x94/0xc8 [ocfs2]
> > > 	[577992.891248]  ocfs2_extend_allocation+0x1bc/0x7a8 [ocfs2]
> > > 	[577992.891269]  ocfs2_allocate_extents+0x14c/0x338 [ocfs2]
> > > 	[577992.891290]  __ocfs2_change_file_space+0x3f8/0x610 [ocfs2]
> > > 	[577992.891309]  ocfs2_fallocate+0xe4/0x128 [ocfs2]
> > > 	[577992.891316]  vfs_fallocate+0x11c/0x250
> > > 	[577992.891317]  ksys_fallocate+0x54/0x88
> > > 	[577992.891319]  __arm64_sys_fallocate+0x28/0x38
> > > 	[577992.891323]  el0_svc_common+0x78/0x130
> > > 	[577992.891325]  el0_svc_handler+0x38/0x78
> > > 	[577992.891327]  el0_svc+0x8/0xc
> > > 
> > > My analysis process as follows:
> > > ocfs2_fallocate
> > >    __ocfs2_change_file_space
> > >      ocfs2_allocate_extents
> > >        ocfs2_extend_allocation
> > >          ocfs2_add_inode_data
> > >            ocfs2_add_clusters_in_btree
> > >              ocfs2_insert_extent
> > >                ocfs2_do_insert_extent
> > >                  ocfs2_rotate_tree_right
> > >                    ocfs2_extend_rotate_transaction
> > >                      ocfs2_extend_trans
> > >                        jbd2_journal_restart
> > >                          jbd2__journal_restart
> > >                            /* handle->h_transaction is NULL,
> > >                             * is_handle_aborted(handle) is true
> > >                             */
> > >                            handle->h_transaction = NULL;
> > >                            start_this_handle
> > >                              return -EROFS;
> > >              ocfs2_free_clusters
> > >                _ocfs2_free_clusters
> > >                  _ocfs2_free_suballoc_bits
> > >                    ocfs2_block_group_clear_bits
> > >                      ocfs2_journal_access_gd
> > >                        __ocfs2_journal_access
> > >                          jbd2_journal_get_undo_access
> > >                            /* I think jbd2_write_access_granted() will
> > >                             * return true, because do_get_write_access()
> > >                             * will return -EROFS.
> > >                             */
> > >                            if (jbd2_write_access_granted(...)) return 0;
> > >                            do_get_write_access
> > >                              /* handle->h_transaction is NULL, it will
> > >                               * return -EROFS here, so do_get_write_access()
> > >                               * was not called.
> > >                               */
> > >                              if (is_handle_aborted(handle)) return -EROFS;
> > >                      /* bh2jh(group_bh) is NULL, caused NULL
> > >                         pointer dereference */
> > >                      undo_bg = (struct ocfs2_group_desc *)
> > >                                  bh2jh(group_bh)->b_committed_data;
> > > 
> > > If handle->h_transaction == NULL, then jbd2_write_access_granted()
> > > does not really guarantee that journal_head will stay around,
> > > not even speaking of its b_committed_data. The bh2jh(group_bh)
> > > can be removed after ocfs2_journal_access_gd() and before call
> > > "bh2jh(group_bh)->b_committed_data". So, we should move
> > > is_handle_aborted() check from do_get_write_access() into
> > > jbd2_journal_get_undo_access() and jbd2_journal_get_write_access()
> > > before the call to jbd2_write_access_granted().
> > > 
> > > Signed-off-by: Yan Wang <wangyan122@huawei.com>
> > > Reviewed-by: Jun Piao <piaojun@huawei.com>
> > 
> > Thanks! The patch looks good to me. You can add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > 								Honza
> > 
> > > ---
> > >   fs/jbd2/transaction.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > > index 2dd848a743ed..d181948c0390 100644
> > > --- a/fs/jbd2/transaction.c
> > > +++ b/fs/jbd2/transaction.c
> > > @@ -936,8 +936,6 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
> > >   	char *frozen_buffer = NULL;
> > >   	unsigned long start_lock, time_lock;
> > > 
> > > -	if (is_handle_aborted(handle))
> > > -		return -EROFS;
> > >   	journal = transaction->t_journal;
> > > 
> > >   	jbd_debug(5, "journal_head %p, force_copy %d\n", jh, force_copy);
> > > @@ -1189,6 +1187,9 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
> > >   	struct journal_head *jh;
> > >   	int rc;
> > > 
> > > +	if (is_handle_aborted(handle))
> > > +		return -EROFS;
> > > +
> > >   	if (jbd2_write_access_granted(handle, bh, false))
> > >   		return 0;
> > > 
> > > @@ -1326,6 +1327,9 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
> > >   	struct journal_head *jh;
> > >   	char *committed_data = NULL;
> > > 
> > > +	if (is_handle_aborted(handle))
> > > +		return -EROFS;
> > > +
> > >   	if (jbd2_write_access_granted(handle, bh, true))
> > >   		return 0;
> > > 
> > > -- 
> > > 2.19.1
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
