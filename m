Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5319C472
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfHYOmk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 10:42:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:53398 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfHYOmk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 25 Aug 2019 10:42:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E9BB3300;
        Sun, 25 Aug 2019 14:42:39 +0000 (UTC)
Date:   Sun, 25 Aug 2019 08:42:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ayush Ranjan <ayushr2@illinois.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Ext4 documentation fixes.
Message-ID: <20190825084238.41b6f912@lwn.net>
In-Reply-To: <20190824230930.GB5163@mit.edu>
References: <CA+UE=SPyMXZUhHFm0KgvihPdaE=yH5ra6n1C4XhKgM6aGheo=A@mail.gmail.com>
        <DEDD6BA5-6E18-4ED6-9EF6-E11EDA593700@dilger.ca>
        <20190824152453.03737143@lwn.net>
        <20190824230930.GB5163@mit.edu>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 24 Aug 2019 19:09:30 -0400
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> If you haven't pushed out your doc tree, can you please drop it?  I've
> already applied an (improved) version of this patch to the ext4 tree,
> and I actually have some plans to do further fixups of ext4 on-disk
> format documentation in the ext4 tree.  So it would be easier if we
> keep ext4 documentation updates in the ext4 git tree.

Sigh...I checked linux-next first and saw no signs of activity there.  Oh
well; I guess I can disappear that change.

jon
