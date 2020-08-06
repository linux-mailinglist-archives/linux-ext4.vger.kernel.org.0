Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A295623D68E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 07:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgHFFtO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 01:49:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49213 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgHFFtN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 01:49:13 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0765mt6s032275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 01:48:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BCF11420263; Thu,  6 Aug 2020 01:48:55 -0400 (EDT)
Date:   Thu, 6 Aug 2020 01:48:55 -0400
From:   tytso@mit.edu
To:     Xianting Tian <xianting_tian@126.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: fix incorrect code style
Message-ID: <20200806054855.GM7657@mit.edu>
References: <1595077057-8048-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595077057-8048-1-git-send-email-xianting_tian@126.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jul 18, 2020 at 08:57:37AM -0400, Xianting Tian wrote:
> Remove unnecessary blank.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>

Thanks, applied.

						- Ted
