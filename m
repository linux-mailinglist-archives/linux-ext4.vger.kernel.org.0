Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC091D337B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgENOtu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:49:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58458 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726176AbgENOtt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:49:49 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEnf5I006413
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:49:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CB172420304; Thu, 14 May 2020 10:49:41 -0400 (EDT)
Date:   Thu, 14 May 2020 10:49:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix EXT_MAX_EXTENT/INDEX to check for zeroed eh_max
Message-ID: <20200514144941.GT1596452@mit.edu>
References: <20200421023959.20879-1-harshadshirwadkar@gmail.com>
 <20200421023959.20879-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421023959.20879-2-harshadshirwadkar@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 20, 2020 at 07:39:59PM -0700, Harshad Shirwadkar wrote:
> If eh->eh_max is 0, EXT_MAX_EXTENT/INDEX would evaluate to unsigned
> (-1) resulting in illegal memory accesses. Although there is no
> consistent repro, we see that generic/019 sometimes crashes because of
> this bug.
> 
> Ran gce-xfstests smoke and verified that there were no regressions.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Applied, thanks.

					- Ted
