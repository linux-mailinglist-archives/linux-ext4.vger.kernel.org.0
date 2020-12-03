Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450C82CD88F
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbgLCOIQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:08:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56118 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388372AbgLCOIQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:08:16 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3E7QMa022902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:07:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2D8A1420136; Thu,  3 Dec 2020 09:07:26 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:07:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH v4 2/2] ext4: print quota journalling mode on (re-)mount
Message-ID: <20201203140726.GE441757@mit.edu>
References: <1603336860-16153-1-git-send-email-dotdot@yandex-team.ru>
 <1603336860-16153-2-git-send-email-dotdot@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603336860-16153-2-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 22, 2020 at 06:21:00AM +0300, Roman Anufriev wrote:
> Right now, it is hard to understand which quota journalling type is enabled:
> you need to be quite familiar with kernel code and trace it or really
> understand what different combinations of fs flags/mount options lead to.
> 
> This patch adds printing of current quota jounalling mode on each
> mount/remount, thus making it easier to check it at a glance/in autotests.
> The semantics is similar to ext4 data journalling modes:
> 
> * journalled - quota configured, journalling will be enabled
> * writeback  - quota configured, journalling won't be enabled
> * none       - quota isn't configured
> * disabled   - kernel compiled without CONFIG_QUOTA feature
> 
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>

Applied, thanks.

						- Ted
