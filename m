Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61F6D0E7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfGRPRj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jul 2019 11:17:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43365 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727685AbfGRPRj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jul 2019 11:17:39 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6IFHX1a026288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 11:17:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 11A92420054; Thu, 18 Jul 2019 11:17:33 -0400 (EDT)
Date:   Thu, 18 Jul 2019 11:17:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shi Siyuan <shisiyuan19870131@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, shisiyuan <shisiyuan@xiaomi.com>
Subject: Re: [PATCH] ext4: remove unnecessary error check
Message-ID: <20190718151732.GA19119@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shi Siyuan <shisiyuan19870131@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shisiyuan <shisiyuan@xiaomi.com>
References: <cover.1562138716.git.shisiyuan@xiaomi.com>
 <f4c9a68280d23b43f8949265d33244012e2b40e4.1562138716.git.shisiyuan@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c9a68280d23b43f8949265d33244012e2b40e4.1562138716.git.shisiyuan@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 03, 2019 at 04:16:54PM +0800, Shi Siyuan wrote:
> From: shisiyuan <shisiyuan@xiaomi.com>
> 
> Remove unnecessary error check in ext4_file_write_iter(),
> because this check will be done in upcoming later function --
> ext4_write_checks() -> generic_write_checks()
> 
> Change-Id: I7b0ab27f693a50765c15b5eaa3f4e7c38f42e01e
> Signed-off-by: shisiyuan <shisiyuan@xiaomi.com>

Thanks, applied.

					- Ted
