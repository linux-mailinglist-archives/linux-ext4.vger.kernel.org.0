Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C732DBA42
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgLPFAY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:00:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38331 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725287AbgLPFAY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Dec 2020 00:00:24 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG4xYoE026134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:59:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 08D5B420280; Tue, 15 Dec 2020 23:59:33 -0500 (EST)
Date:   Tue, 15 Dec 2020 23:59:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 01/12] ext4: Don't remount read-only with errors=continue
 on reboot
Message-ID: <X9mUNZGV91GouNhB@mit.edu>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-2-jack@suse.cz>
 <AEF7E6AA-9663-4470-A689-FD55062EC8CA@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEF7E6AA-9663-4470-A689-FD55062EC8CA@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 29, 2020 at 02:33:35PM -0700, Andreas Dilger wrote:
> On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > ext4_handle_error() with errors=continue mount option can accidentally
> > remount the filesystem read-only when the system is rebooting. Fix that.
> > 
> > Fixes: 1dc1097ff60e ("ext4: avoid panic during forced reboot")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
