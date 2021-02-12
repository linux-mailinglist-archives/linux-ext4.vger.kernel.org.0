Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4016319FD8
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhBLN2V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 08:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhBLN2U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 08:28:20 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004FC061574
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 05:27:39 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1613136457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abmhc/O6LL6CCcibUnTCVVausxn9FLnfqs9lo2ddQXU=;
        b=I9VoNmqP5rGuqmGSAS3On57PpQEdcVeVFk68y9ZlVEVKyGoMLAjoG2gz271M9gNJvLCY9E
        qmJqWBC4Ri/ER5XOVV1g7FlVnCTczb+x+pZEalryeGhII9CRGiUcI1aUXRyp4iFhiHgCc5
        qoV0LaheeEhdazn4L5ZX47j+nf7+x7/CTMlm8JXnoX9tjQDBx/wytCQZo0x4I1E5qX8m+q
        sWckv8SIoMAGfBh4Fk6Dmp65dV5ctUQe6NSLYKCWZRAIf0u+7P9kS3FiV/HeLMuF7dfZEw
        LT/ri+gT7th1U8RXk0gfVGm53mDg9yLh+xwDe+SUqodlh7mCebByT384P1x9fw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 Feb 2021 08:27:36 -0500
Message-Id: <C97L5DF7C3QF.H25PQ5ERKEPL@taiga>
Subject: Re: j_recover_fast_commit: : failed on musl-riscv64
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>
References: <C96ZW60NLAQF.1JF09JLHKR51M@taiga> <YCX+Em/EUJJte3x1@mit.edu>
In-Reply-To: <YCX+Em/EUJJte3x1@mit.edu>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu Feb 11, 2021 at 11:03 PM EST, Theodore Ts'o wrote:
> Can you try using glibc on RiscV and see if it passes with glibc?

Hm, I don't have a glibc+RISC-V setup readily available for testing, nor
could I obtain one easily. But I would be open to offering shell access
in my musl environment for troubleshooting purposes - would you (or
any other maintainers) find that helpful?
