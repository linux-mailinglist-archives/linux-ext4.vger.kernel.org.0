Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6371044556A
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 15:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKDOja (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 10:39:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59725 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229505AbhKDOj3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 10:39:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A4EanwW012934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Nov 2021 10:36:50 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 925B615C00B9; Thu,  4 Nov 2021 10:36:49 -0400 (EDT)
Date:   Thu, 4 Nov 2021 10:36:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: enforce buffer head state assertion in
 ext4_da_map_blocks"
Message-ID: <YYPwAZq7UBdiRPdb@mit.edu>
References: <20211012171901.5352-1-enwlinux@gmail.com>
 <163415796177.214938.9752602885736039327.b4-ty@mit.edu>
 <20211103191457.GA3838@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103191457.GA3838@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 03, 2021 at 03:14:57PM -0400, Eric Whitney wrote:
> 
> This reversion isn't visible in the 5.15 kernel.  We'll want to get this in as
> a bug fix to 5.15.1 if possible.  Please let me know if there's anything I can
> do to expedite.

Ack, I forgot to send a pull request to Linus before 5.15 went out,
sorry about that.  I've updated the commit description to include a
cc:stable and it will be going out with the other ext4 patches for
this merge window.

Cheers,

					- Ted
