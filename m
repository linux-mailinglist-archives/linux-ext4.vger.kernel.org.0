Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B21330CF
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgAGUof (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 15:44:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32798 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726530AbgAGUof (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 15:44:35 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007KhWbG017294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 15:43:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5B18D4207DF; Tue,  7 Jan 2020 15:43:32 -0500 (EST)
Date:   Tue, 7 Jan 2020 15:43:32 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v3 2/8] random: Add a urandom_read_nowait() for random
 APIs that don't warn
Message-ID: <20200107204332.GG3619@mit.edu>
References: <cover.1577088521.git.luto@kernel.org>
 <c87ab200588de746431d9f916501ef11e5242b13.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87ab200588de746431d9f916501ef11e5242b13.1577088521.git.luto@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 23, 2019 at 12:20:45AM -0800, Andy Lutomirski wrote:
> /dev/random and getrandom() never warn.  Split the meat of
> urandom_read() into urandom_read_nowarn() and leave the warning code
> in urandom_read().
> 
> This has no effect on kernel behavior, but it makes subsequent
> patches more straightforward.  It also makes the fact that
> getrandom() never warns more obvious.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Applied, thanks.

					- Ted
