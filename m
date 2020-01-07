Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F688133372
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAGVSx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 16:18:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36538 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729153AbgAGVE6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 16:04:58 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007L3slH024808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:03:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C30C44207DF; Tue,  7 Jan 2020 16:03:54 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:03:54 -0500
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
Subject: Re: [PATCH v3 7/8] random: Delete code to pull data into pools
Message-ID: <20200107210354.GL3619@mit.edu>
References: <cover.1577088521.git.luto@kernel.org>
 <4a05fe0c7a5c831389ef4aea51d24528ac8682c7.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a05fe0c7a5c831389ef4aea51d24528ac8682c7.1577088521.git.luto@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 23, 2019 at 12:20:50AM -0800, Andy Lutomirski wrote:
> There is no pool that pulls, so it was just dead code.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Applied, thanks.

					- Ted
