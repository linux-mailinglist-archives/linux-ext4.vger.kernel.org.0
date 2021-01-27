Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39A730673E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 23:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhA0Wwz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 17:52:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58210 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230526AbhA0Wwv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 17:52:51 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10RMgcgv029032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 17:42:39 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6779915C344F; Wed, 27 Jan 2021 17:42:38 -0500 (EST)
Date:   Wed, 27 Jan 2021 17:42:38 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org, drosen@google.com,
        krisman@collabora.com, ebiggers@kernel.org
Subject: Re: [PATCH RESEND v2 01/12] tune2fs: Allow enabling casefold feature
 after fs creation
Message-ID: <YBHsXp8TZ+R0bxR7@mit.edu>
References: <20201210150353.91843-1-arnaud.ferraris@collabora.com>
 <20201210150353.91843-2-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210150353.91843-2-arnaud.ferraris@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 04:03:42PM +0100, Arnaud Ferraris wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> The main reason we didn't allow this before was because !CASEFOLDED
> directories were expected to be normalized().  Since this is no longer
> the case, and as long as the encrypt feature is not enabled, it should
> be safe to enable this feature.
> 
> Disabling the feature is trickier, since we need to make sure there are
> no existing +F directories in the filesystem.  Leave that for a future
> patch.
> 
> Also, enabling strict mode requires some filesystem-wide verification,
> so ignore that for now.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Thanks, applied.

					- Ted
