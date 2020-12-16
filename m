Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E901C2DBA02
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 05:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgLPEVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 23:21:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33066 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgLPEVI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 23:21:08 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG4KJ1H013322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:20:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 144EE420280; Tue, 15 Dec 2020 23:20:19 -0500 (EST)
Date:   Tue, 15 Dec 2020 23:20:18 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kang Wenlin <wenlin.kang@windriver.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix -Wstringop-truncation warnings
Message-ID: <X9mLAlWbjrU5iE+r@mit.edu>
References: <20201112093324.8052-1-wenlin.kang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112093324.8052-1-wenlin.kang@windriver.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 12, 2020 at 05:33:24PM +0800, Kang Wenlin wrote:
> From: Wenlin Kang <wenlin.kang@windriver.com>
> 
> The strncpy() function may create a unterminated string,
> use strscpy_pad() instead.
> 
> This fixes the following warning:
> 
> fs/ext4/super.c: In function '__save_error_info':
> fs/ext4/super.c:349:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ext4/super.c:353:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>    strncpy(es->s_first_error_func, func,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     sizeof(es->s_first_error_func));
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

What compiler are you using?  s_last_error_func is defined to not
necessarily be NUL terminated.  So strscpy_pad() is not a proper
replacement for strncpy() in this use case.

From Documentation/process/deprecated:

   If a caller is using non-NUL-terminated strings, strncpy() can
   still be used, but destinations should be marked with the `__nonstring
   <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
   attribute to avoid future compiler warnings.

s_{first,last}_error_func is properly annotated with __nonstring in
fs/ext4/ext4.h.

						- Ted
