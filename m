Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A852280495
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbgJARIX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 13:08:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55193 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732213AbgJARIV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 13:08:21 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091H8HJJ002370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 13:08:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CA27A42003C; Thu,  1 Oct 2020 13:08:17 -0400 (EDT)
Date:   Thu, 1 Oct 2020 13:08:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tests: replace perl usage with shell built-in
Message-ID: <20201001170817.GL23474@mit.edu>
References: <20200719110033.78844-1-adilger@dilger.ca>
 <20201001145809.GA584291@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001145809.GA584291@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 01, 2020 at 10:58:09AM -0400, Theodore Y. Ts'o wrote:
> On Sun, Jul 19, 2020 at 05:00:33AM -0600, Andreas Dilger wrote:
> > A couple of tests use perl only for generating a string of
> > N characters long.  Instead of requiring perl to run a few
> > tests, use shell built-in commands and don't repeatedly run
> > a separate subshell just to get a string of characters.
> > h
> > Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> 
> Thanks, applied.

.... and I have to revert the patch.  It's using a non-standard shell
construction which fails on strict POSIX compliant shells, such as
dash.

						- Ted
