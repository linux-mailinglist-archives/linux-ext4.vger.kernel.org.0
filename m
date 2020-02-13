Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD28015C129
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBMPOi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 10:14:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46937 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727414AbgBMPOi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Feb 2020 10:14:38 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01DFEXpn005327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 10:14:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AE7D342032C; Thu, 13 Feb 2020 10:14:32 -0500 (EST)
Date:   Thu, 13 Feb 2020 10:14:32 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: simplify checking quota limits in ext4_statfs()
Message-ID: <20200213151432.GA288055@mit.edu>
References: <20200130111148.10766-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130111148.10766-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 30, 2020 at 12:11:48PM +0100, Jan Kara wrote:
> Coverity reports that conditions checking quota limits in ext4_statfs()
> contain dead code. Indeed it is right and current conditions can be
> simplified.
> 
> Reported-by: Coverity <scan-admin@coverity.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
