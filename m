Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35E23D5F3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgHFEJn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 00:09:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40699 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgHFEJn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 00:09:43 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07649bus012151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 00:09:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 12C61420263; Thu,  6 Aug 2020 00:09:37 -0400 (EDT)
Date:   Thu, 6 Aug 2020 00:09:36 -0400
From:   tytso@mit.edu
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: Delete unnecessary checks before brelse()
Message-ID: <20200806040936.GA7657@mit.edu>
References: <0d713702-072f-a89c-20ec-ca70aa83a432@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d713702-072f-a89c-20ec-ca70aa83a432@web.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 13, 2020 at 08:07:56PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 13 Jun 2020 19:12:24 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus remove the tests which are not needed around the shown calls.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied, thanks.

						- Ted
