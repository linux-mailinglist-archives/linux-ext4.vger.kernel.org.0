Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158711EDD2F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jun 2020 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFDG1D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jun 2020 02:27:03 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17191 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgFDG1A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Jun 2020 02:27:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591252014; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=axuw/og/0SBtIs7v1VxHjxDYK6qG3rBrEk4yNAM5u1i66EBwB1hYdVvt+RWQnFiRLt75ubUEF/H/XbWdp4FLIVoA2yDr5A3tfE8x1bPMNlYEdrYNWLubxvkPG4593whGzDMvm6sy6+bKF3lQqNcWiKZYSowTXpvJ9zmcx+fUT0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1591252014; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hB6eEYcFUT0usHlsMngAxAuisvsix1M+/W2Cex7Lw+o=; 
        b=nVmJrnsWgmAJen2/rCFUcMponpGRE+1lxR2+bUdgIIpo9FGWulhOvFFRycGaVmhkU0Ox69mbh5h08oVU0B4G0qES9W1sWSJrexqA7rldY2h5Qc/HcMzchyKaSKlovv9Qhwl6JifjP8alwlPkfQf2kN3f0KRkBLzVxyRjGMnkvqA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591252014;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=hB6eEYcFUT0usHlsMngAxAuisvsix1M+/W2Cex7Lw+o=;
        b=S9tz31UUdziMYJakb0EvlX2IQlkPSUVv169sAoH5VlpVviuqY4gUsTpgF+gEQ1Oy
        XViIiSphSIUxiFhyrAWB1XXD+nyJT4iOjHDqyzxn8j8xpSaaf4FcOk5eKClJe1nvP+7
        rY/3JkrGHVdKcFg9R3CcTj9ZPWtu9nrHbYt5UFAY=
Received: from [192.168.166.138] (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1591252010129892.6626369129234; Thu, 4 Jun 2020 14:26:50 +0800 (CST)
Subject: Re: [RFC PATCH] ext2: drop cached block when detecting corruption
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org
References: <20200603094417.6143-1-cgxu519@mykernel.net>
From:   cgxu <cgxu519@mykernel.net>
Message-ID: <398a6fd8-37ee-c323-b606-c8679067e540@mykernel.net>
Date:   Thu, 4 Jun 2020 14:26:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200603094417.6143-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 6/3/20 5:44 PM, Chengguang Xu wrote:
> Currently ext2 uses mdcache for deduplication of extended
> attribution blocks. However, there is lack of handling for
> corrupted blocks, so newly created EAs may still links to
> corrupted blocks. This patch tries to drop cached block
> when detecting corruption to mitigate the effect.

ext2_xattr_cmp() will carefully check every entry in the block,
so there is no chance to link to corrupted block, maybe we can
improve the speed of cache related operations by dropping
corrupted blocks.


Thanks,
cgxu
