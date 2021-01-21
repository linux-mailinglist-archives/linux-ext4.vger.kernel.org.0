Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD582FF8CE
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 00:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAUX0t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 18:26:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40444 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbhAUX0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 18:26:25 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LNPSAr025808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 18:25:29 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ADBEC15C35F5; Thu, 21 Jan 2021 18:25:28 -0500 (EST)
Date:   Thu, 21 Jan 2021 18:25:28 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH e2fsprogs] build: Add SYSLIBS to e4crypt linking
Message-ID: <YAoNaGo3jLlXftWD@mit.edu>
References: <20201215230557.17211-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215230557.17211-1-hauke@hauke-m.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 16, 2020 at 12:05:57AM +0100, Hauke Mehrtens wrote:
> The $(SYSLIBS) was missing when linking the e4crypt application. This is
> available in the e4crypt.profiled variant, so I assume this was just
> missing in the normal variant and is not left out intentionally.

Thanks, I've applied.  It was left out unintentionally, although I
don't see how this is affecting building e2fsprogs with
-fsanitize=undefined in the global CFLAGS and LDFLAGS.  (Which worked
for me both before and after applying this change.)

						- Ted
