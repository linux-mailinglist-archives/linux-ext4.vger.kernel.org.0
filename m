Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4802CD88E
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgLCOIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:08:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56076 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726257AbgLCOIE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:08:04 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3E7De7022832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:07:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 51E9F420136; Thu,  3 Dec 2020 09:07:13 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:07:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH v4 1/2] ext4: add helpers for checking whether quota can
 be enabled/is journalled
Message-ID: <20201203140713.GD441757@mit.edu>
References: <1603336860-16153-1-git-send-email-dotdot@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603336860-16153-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 22, 2020 at 06:20:59AM +0300, Roman Anufriev wrote:
> Right now, there are several places, where we check whether fs is
> capable of enabling quota or if quota is journalled with quite long
> and non-self-descriptive condition statements.
> 
> This patch wraps these statements into helpers for better readability
> and easier usage.
> 
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>

Applied, thanks.

					- Ted
