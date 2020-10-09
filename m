Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF78728803A
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 04:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgJICIJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 22:08:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44313 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgJICIJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 22:08:09 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 099280xf001838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 22:08:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2EEC4420107; Thu,  8 Oct 2020 22:08:00 -0400 (EDT)
Date:   Thu, 8 Oct 2020 22:08:00 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        dann frazier <dann.frazier@canonical.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v5 2/4] jbd2, ext4, ocfs2: introduce/use journal
 callbacks j_submit|finish_inode_data_buffers()
Message-ID: <20201009020800.GF235506@mit.edu>
References: <20201006004841.600488-1-mfo@canonical.com>
 <20201006004841.600488-3-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006004841.600488-3-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 09:48:39PM -0300, Mauricio Faria de Oliveira wrote:
> Introduce journal callbacks to allow different behaviors
> for an inode in journal_submit|finish_inode_data_buffers().
> 
> The existing users of the current behavior (ext4, ocfs2)
> are adapted to use the previously exported functions
> that implement the current behavior.
> 
> Users are callers of jbd2_journal_inode_ranged_write|wait(),
> which adds the inode to the transaction's inode list with
> the JI_WRITE|WAIT_DATA flags. Only ext4 and ocfs2 in-tree.
> 
> Both CONFIG_EXT4_FS and CONFIG_OCSFS2_FS select CONFIG_JBD2,
> which builds fs/jbd2/commit.c and journal.c that define and
> export the functions, so we can call directly in ext4/ocfs2.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
