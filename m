Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6047E9E0
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Dec 2021 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350466AbhLXA2O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 19:28:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41356 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350458AbhLXA2N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 19:28:13 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BO0RqHR003092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 19:27:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7974415C00C8; Thu, 23 Dec 2021 19:27:52 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Czerner <lczerner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH REPOST REPOST] ext4: Destroy ext4_fc_dentry_cachep kmemcache on module removal.
Date:   Thu, 23 Dec 2021 19:27:49 -0500
Message-Id: <164030564165.2940033.3088049106332520646.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211223164436.2628390-1-bigeasy@linutronix.de>
References: <20211223164436.2628390-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 23 Dec 2021 17:44:36 +0100, Sebastian Andrzej Siewior wrote:
> The kmemcache for ext4_fc_dentry_cachep remains registered after module
> removal.
> 
> Destroy ext4_fc_dentry_cachep kmemcache on module removal.
> 
> 

Applied, thanks!

[1/1] ext4: Destroy ext4_fc_dentry_cachep kmemcache on module removal.
      commit: 46336e7e7275d2714f8abeb5fd62595931f8e9aa

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
