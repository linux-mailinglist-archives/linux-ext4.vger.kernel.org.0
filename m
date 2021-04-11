Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C397E35B78A
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhDKX7B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Apr 2021 19:59:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38329 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235722AbhDKX7A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Apr 2021 19:59:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13BNwYsK027373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Apr 2021 19:58:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6211D15C3B0D; Sun, 11 Apr 2021 19:58:34 -0400 (EDT)
Date:   Sun, 11 Apr 2021 19:58:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ryan Schmidt <ryandesign@macports.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: e2fsprogs 1.46.2 needs #include <time.h> in probe.c
Message-ID: <YHONKmt/ohlE8xJQ@mit.edu>
References: <A283A764-EBEB-4273-92D4-FC26129745E4@macports.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A283A764-EBEB-4273-92D4-FC26129745E4@macports.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 11, 2021 at 07:57:33AM -0500, Ryan Schmidt wrote:
> Hi,
> 
> I am the maintainer of e2fsprogs in MacPorts. The developer of
> e2fsprogs has asked me to report patches for his program to this
> mailing list.
> 
> e2fsprogs 1.46.2 does not build on macOS when implicit declaration
> of functions is considered an error. This condition can be achieved
> either by adding -Werror=implicit-function-declaration to CFLAGS
> when configuring or by compiling with the version of clang included
> with Xcode 12 or later on macOS in which that behavior is the
> default.

Hi Ryan,

Thanks for the bug report and proposed fix.  I've applied it to the
e2fsprogs git tree.

Cheers,

					- Ted
