Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D71C9360
	for <lists+linux-ext4@lfdr.de>; Thu,  7 May 2020 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgEGPCY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 May 2020 11:02:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44455 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726356AbgEGPCY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 May 2020 11:02:24 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 047F1EeC022765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 May 2020 11:01:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 237DE421C7D; Thu,  7 May 2020 11:01:14 -0400 (EDT)
Date:   Thu, 7 May 2020 11:01:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiakaixu1987@gmail.com
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: remove unnecessary test_opt for DIOREAD_NOLOCK
Message-ID: <20200507150114.GL404484@mit.edu>
References: <1586751862-19437-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586751862-19437-1-git-send-email-kaixuxia@tencent.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 13, 2020 at 12:24:22PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The DIOREAD_NOLOCK flag has been cleared when doing the test_opt
> that is meaningless, so remove the unnecessary test_opt for DIOREAD_NOLOCK.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Applied, thanks.

					- Ted
