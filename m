Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224433BC462
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 02:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGFAbh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 20:31:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47434 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229722AbhGFAbh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 20:31:37 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1660SsuN005735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 20:28:54 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 365A015C3C96; Mon,  5 Jul 2021 20:28:54 -0400 (EDT)
Date:   Mon, 5 Jul 2021 20:28:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michael Forney <mforney@mforney.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] libext2fs: use statement-expression for container_of
 only on GNU-compatible compilers
Message-ID: <YOOjxsfoOnZHDNA+@mit.edu>
References: <20210414074128.31268-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414074128.31268-1-mforney@mforney.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 14, 2021 at 12:41:27AM -0700, Michael Forney wrote:
> Functionally, the statement-expression is not necessary here; it
> just gives a bit of type-safety to make sure the pointer really
> does have a compatible type with the specified member of the struct.
> 
> When statement expressions are not available, we can just use a
> portable fallback macro that skips this member type check.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>

Applied, thanks.

						- Ted
