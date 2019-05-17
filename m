Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBF21F27
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfEQUmc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 16:42:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37511 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbfEQUmc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 16:42:32 -0400
Received: from callcc.thunk.org (75-104-86-155.mobility.exede.net [75.104.86.155] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4HKgGRv017037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 16:42:23 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9D722420025; Fri, 17 May 2019 16:28:10 -0400 (EDT)
Date:   Fri, 17 May 2019 16:28:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190517202810.GA21961@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517102506.GU4319@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 17, 2019 at 11:25:06AM +0100, Lee Jones wrote:
> On Fri, 17 May 2019, Philippe Mazenauer wrote:
> 
> > Variables 'n' and 'err' are both used for less-than-zero error checking,
> > however both are declared as unsigned. Ensure ext4_map_blocks() and
> > add_system_zone() are able to have their return values propagated
> > correctly by redefining them both as signed integers.

This is already fixed in the ext4.git tree; it will be pushed to Linus
shortly.  (Thanks to Colin Ian King from Canonical for sending the
patch.)

> Acked-by: Lee Jones <lee.jones@linaro.org>

Lee, techncially this should have been Reviewed-by.  Acked-by is used
by the maintainer when a patch is going in via some other tree other
than the Maintainer's (it means the Maintainer has acked the patch).
If you are reviewing a patch, the tag you should be adding is
Reviewed-by.

Cheers,

					- Ted
