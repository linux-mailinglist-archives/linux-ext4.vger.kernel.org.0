Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF697458D85
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Nov 2021 12:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhKVLjJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 06:39:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbhKVLjJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 06:39:09 -0500
Date:   Mon, 22 Nov 2021 12:36:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637580962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKSjikr/8xCyrhAvYNMPKio9tf/JpDQEKI6PRpVMx8I=;
        b=E5xat4aMeTPYrbcX39vuVr2upxgevGBXUGsjhCTH1ZPHzc6aG162Ifnkx9/84OXAVgh1lO
        8v1r02f+/U9hGMwFokTvLgY3xwJL/LJkYQx943AppduQoTuMA3tqS7A4/aKnXDgdlrgb7M
        2PekxIyZSnobanRyNxoeLUec/+8d6Dnvcvj1aWFUaXYLEnsLD0uG89iEMXg3Y31ZF/ms4s
        V1Ca3ooppnS7kE6KVkuaGzkvk6EYDWuYSP4q7acHXTXoD1Clfxmm3mUv5I9vzcLPaxI61I
        F2bZy4l3I4T3FnrRcYVK0sx5/f0d4HMmmwOOVVO6OB3K+tUGXdN3vI9wuduAOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637580962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKSjikr/8xCyrhAvYNMPKio9tf/JpDQEKI6PRpVMx8I=;
        b=o0f1Fkautw6kwZwZlKRrYN/Nqo3pD2E+RS2EA4QDTsl1EYKlISc1ickH5QNKvuNOO7CD9w
        s45AZKLgjRx2+uCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ext4: Destroy ext4_fc_dentry_cachep kmemcache on module
 removal.
Message-ID: <20211122113600.uds3ygyu2gh5qujk@linutronix.de>
References: <20211110134640.lyku5vklvdndw6uk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110134640.lyku5vklvdndw6uk@linutronix.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021-11-10 14:46:43 [+0100], To linux-ext4@vger.kernel.org wrote:
> The kmemcache for ext4_fc_dentry_cachep remains registered after module
> removal.
> 
> Destroy ext4_fc_dentry_cachep kmemcache on module removal.
> 
> Fixes: aa75f4d3daaeb ("ext4: main fast-commit commit path")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ping ;)

Sebastian
