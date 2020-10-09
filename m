Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A24288038
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 04:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgJICHl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 22:07:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44069 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgJICHl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 22:07:41 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09925P2I032441
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 22:05:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8274F420107; Thu,  8 Oct 2020 22:05:25 -0400 (EDT)
Date:   Thu, 8 Oct 2020 22:05:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        dann frazier <dann.frazier@canonical.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v5 1/4] jbd2: introduce/export functions
 jbd2_journal_submit|finish_inode_data_buffers()
Message-ID: <20201009020525.GE235506@mit.edu>
References: <20201006004841.600488-1-mfo@canonical.com>
 <20201006004841.600488-2-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006004841.600488-2-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 09:48:38PM -0300, Mauricio Faria de Oliveira wrote:
> Export functions that implement the current behavior done
> for an inode in journal_submit|finish_inode_data_buffers().
> 
> No functional change.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
