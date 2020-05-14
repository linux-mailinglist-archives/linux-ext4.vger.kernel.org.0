Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F571D329F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgENOV2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:21:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54135 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgENOV2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:21:28 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEKGiG028521
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:20:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 05569420304; Thu, 14 May 2020 10:20:15 -0400 (EDT)
Date:   Thu, 14 May 2020 10:20:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiakaixu1987@gmail.com
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: remove redundant variable has_bigalloc in
 ext4_fill_super
Message-ID: <20200514142015.GA2060213@mit.edu>
References: <1586935542-29588-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586935542-29588-1-git-send-email-kaixuxia@tencent.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 15, 2020 at 03:25:42PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We can use the ext4_has_feature_bigalloc() function directly to check
> bigalloc feature and the variable has_bigalloc is reduncant, so remove
> it.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Applied, thanks.

						- Ted
