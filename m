Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597E01A41F6
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Apr 2020 06:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgDJEcR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Apr 2020 00:32:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34567 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbgDJEcR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Apr 2020 00:32:17 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03A4WDZr013368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 00:32:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2B78342013D; Fri, 10 Apr 2020 00:32:13 -0400 (EDT)
Date:   Fri, 10 Apr 2020 00:32:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2fs: Fix off-by-one in dx_grow_tree()
Message-ID: <20200410043213.GL45598@mit.edu>
References: <20200330090932.29445-1-jack@suse.cz>
 <20200330090932.29445-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330090932.29445-3-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 30, 2020 at 11:09:32AM +0200, Jan Kara wrote:
> There is an off-by-one error in dx_grow_tree() when checking whether we
> can add another level to the tree. Thus we can grow tree too much
> leading to possible crashes in the library or corrupted filesystem. Fix
> the bug.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
