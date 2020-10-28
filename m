Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6451229D27E
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgJ1VdA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:33:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56435 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725827AbgJ1Vcx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 17:32:53 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09S3uhbe025303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 23:56:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C10C420107; Tue, 27 Oct 2020 23:56:43 -0400 (EDT)
Date:   Tue, 27 Oct 2020 23:56:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Mauricio Faria de Oliveira <mfo@canonical.com>
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
Message-ID: <20201028035643.GP5691@mit.edu>
References: <20201027132751.29858-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027132751.29858-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 27, 2020 at 02:27:51PM +0100, Jan Kara wrote:
> Commit afb585a97f81 "ext4: data=journal: write-protect pages on
> j_submit_inode_data_buffers()") added calls ext4_jbd2_inode_add_write()
> to track inode ranges whose mappings need to get write-protected during
> transaction commits. However the added calls use wrong start of a range
> (0 instead of page offset) and so write protection is not necessarily
> effective. Use correct range start to fix the problem.
> 
> Fixes: afb585a97f81 ("ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()")
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
