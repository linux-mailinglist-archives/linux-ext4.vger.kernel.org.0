Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02A57012
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2019 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFZRyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jun 2019 13:54:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:41086 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfFZRyu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Jun 2019 13:54:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EAEAE537;
        Wed, 26 Jun 2019 17:54:49 +0000 (UTC)
Date:   Wed, 26 Jun 2019 11:54:48 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: Remove uneeded .rst extension on
 toctables
Message-ID: <20190626115448.706a9a8e@lwn.net>
In-Reply-To: <d2e4dfee7708a3ef6130d3ffcc579429de6a05c9.1561556105.git.mchehab+samsung@kernel.org>
References: <d2e4dfee7708a3ef6130d3ffcc579429de6a05c9.1561556105.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 26 Jun 2019 10:35:11 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> There's no need to use a .rst on Sphinx toc tables. As most of
> the Documentation don't use, remove the remaing occurrences.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon
