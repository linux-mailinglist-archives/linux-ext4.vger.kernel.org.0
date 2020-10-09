Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951BF28803E
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgJICKZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 22:10:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45204 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgJICKZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 22:10:25 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0992ABgG003427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 22:10:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8F0EA420107; Thu,  8 Oct 2020 22:10:11 -0400 (EDT)
Date:   Thu, 8 Oct 2020 22:10:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        dann frazier <dann.frazier@canonical.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v5 3/4] ext4: data=journal: fixes for ext4_page_mkwrite()
Message-ID: <20201009021011.GG235506@mit.edu>
References: <20201006004841.600488-1-mfo@canonical.com>
 <20201006004841.600488-4-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006004841.600488-4-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 09:48:40PM -0300, Mauricio Faria de Oliveira wrote:
> These are two fixes for data journalling required by
> the next patch, discovered while testing it.
> 
> First, the optimization to return early if all buffers
> are mapped is not appropriate for the next patch:
> 
> The inode _must_ be added to the transaction's list in
> data=journal mode (so to write-protect pages on commit)
> thus we cannot return early there.
> 
> Second, once that optimization to reduce transactions
> was disabled for data=journal mode, more transactions
> happened, and occasionally hit this warning message:
> 'JBD2: Spotted dirty metadata buffer'.
> 
> Reason is, block_page_mkwrite() will set_buffer_dirty()
> before do_journal_get_write_access() that is there to
> prevent it. This issue was masked by the optimization.
> 
> So, on data=journal use __block_write_begin() instead.
> This also requires page locking and len recalculation.
> (see block_page_mkwrite() for implementation details.)
> 
> Finally, as Jan noted there is little sharing between
> data=journal and other modes in ext4_page_mkwrite().
> 
> However, a prototype of ext4_journalled_page_mkwrite()
> showed there still would be lots of duplicated lines
> (tens of) that didn't seem worth it.
> 
> Thus this patch ends up with an ugly goto to skip all
> non-data journalling code (to avoid long indentations,
> but that can be changed..) in the beginning, and just
> a conditional in the transaction section.
> 
> Well, we skip a common part to data journalling which
> is the page truncated check, but we do it again after
> ext4_journal_start() when we re-acquire the page lock
> (so not to acquire the page lock twice needlessly for
> data journalling.)
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

				- Ted
