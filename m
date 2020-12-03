Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818312CD97B
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgLCOns (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:43:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34599 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730980AbgLCOns (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:43:48 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3EgwMe004797
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:42:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5FC86420136; Thu,  3 Dec 2020 09:42:58 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:42:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 2/8] ext4: remove redundant mb_regenerate_buddy()
Message-ID: <20201203144258.GK441757@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-2-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604764698-4269-2-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 07, 2020 at 11:58:12PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> After this patch (163a203), if an abnormal bitmap is detected, we
> will mark the group as corrupt, and we will not use this group in
> the future. Therefore, it should be meaningless to regenerate the
> buddy bitmap of this group, It might be better to delete it.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
