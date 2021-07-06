Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0569D3BC4F0
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 04:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGFC6K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 22:58:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36490 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229827AbhGFC6G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 22:58:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1662tOpw018986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 22:55:25 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A2FBF15C3C96; Mon,  5 Jul 2021 22:55:24 -0400 (EDT)
Date:   Mon, 5 Jul 2021 22:55:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michael Forney <mforney@mforney.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] libext2fs: use offsetof() from stddef.h
Message-ID: <YOPGHGlM2an3f8rK@mit.edu>
References: <20210414074128.31268-1-mforney@mforney.org>
 <20210414074128.31268-2-mforney@mforney.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414074128.31268-2-mforney@mforney.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 14, 2021 at 12:41:28AM -0700, Michael Forney wrote:
> offsetof is a standard C feature available from stddef.h, going
> back all the way to ANSI C.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>

Thanks, applied.

> Perhaps there is some reason to prefer compiler builtins over libc
> that I'm not seeing?

It's because I pulled container_of from the kernel, and the kernel
header files has to provide offsetof since we don't use the standard
header files --- and it has to work across a bunch of compilers and
architectures.

						- Ted
