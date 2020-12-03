Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820372CD91E
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgLCOaf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:30:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60424 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727772AbgLCOaf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:30:35 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3ESYKh031441
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:28:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DF474420136; Thu,  3 Dec 2020 09:28:33 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:28:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiakaixu1987@gmail.com
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: do the quotafile name safe check before allocating
 new string
Message-ID: <20201203142833.GI441757@mit.edu>
References: <1603723397-14344-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603723397-14344-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 26, 2020 at 10:43:17PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Now we do the quotafile name safe check after allocating the new string
> by using kmalloc(), and have to release the string with kfree() if check
> fails. Maybe we can check them before allocating memory and directly
> return error if check fails to avoid the unnecessary kmalloc()/kfree()
> operations.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  fs/ext4/super.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)

This patch reduces the line count by 3, which is good, but...

(a) It makes the code more complex, harder to read, and harder to be
    sure things are correct:

compare:

> -		if (strcmp(old_qname, qname) == 0)

with

> +		if (strlen(old_qname) != args->to - args->from ||
> +		    strncmp(old_qname, args->from, args->to - args->from)) {

(b) This is optimizing the error path, which is uncommon, and saving
    the allocation and free is not really worth trading off making the code
    slightly harder to read and maintain.

So I don't think taking this patch is worthwhile.

Cheers,

					- Ted
