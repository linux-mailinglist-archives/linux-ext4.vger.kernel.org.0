Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8225DE8E89
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2019 18:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJ2RsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Oct 2019 13:48:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40293 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJ2RsE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Oct 2019 13:48:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id u22so16256223lji.7
        for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2019 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R35NzCe37FoRr+JmWaRxXNrs+ANr5l1yDPp+eQUm8vU=;
        b=cIKrfG2BcBsU9hYXIpQdSwopgElTE4RautsHm9ZOuGHXTi69dKNkh17wSQH/L4zosA
         DI1JpADSu0a3R25/VXr5Iz0OjSuf3z6tAsWgiVO+H5ZF/9VP2xOxAKxjdhdoLpjleNL1
         GGQBMKSg8yP8LIjunquGxXVF8tAxYNJNCdEfsXnbnr55B8bLQDyruSeqzDYclYPGSbAm
         HJjhrG4J94CdXOlytO9LgDMPwdYA+nprQ2rf2m4rCZfPfrNaJYmSZ90g3N59yzI3oBGl
         vPR4bxKynazkligieSoyOTOws2e6shukr1fmmOZGMEygc+XcvpYmK61rppkwFwgRbTjB
         zPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R35NzCe37FoRr+JmWaRxXNrs+ANr5l1yDPp+eQUm8vU=;
        b=PLlB3F3dTQlqF+FXbohsWLAPYnGXivEXt+vfInsxO49tE99PKIDCfZ6mAHtGEJVqeR
         sBIw1yQHylirwyuLLlYL0GdeJrd/aWtVMl5CBZPTHW/8ea3AgkyN5a68yOAoqNQDVzSI
         5B5Tt5xycXsLkQFTtgjHefrhZcQqd1hqENvSubzGfNEH5DUX3yNpAbrbXZKyrI/4UeR+
         q6u0wndPElLMzxgVkXXJtonu0iQi81ee6NqfDwhzdeBtc9Ng5Dof2nzXK7mcxjuO7PFb
         fozyjrYFRXEpzrZzyeFq5I+9dmvofEBel+EwpzCFuFOwvEeqW94hQLZgLZwUz72jVfnY
         YRdg==
X-Gm-Message-State: APjAAAXbHOqxcUTmPH+bW96dno0cyCA3qzbFhjgFy7/RCccvdaMJCsix
        54FoLDJqpi65lhf084VK4mu2yCx7ioHAMx8NluykPA==
X-Google-Smtp-Source: APXvYqwNTLBO6ek7haLq57qS7qFh4V78zjcOU4/j+rzIkHP000hEzkPtfT9hnV441B6ZiktsLU57y15HuzMTPyrd4yw=
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr3387439ljj.247.1572371282017;
 Tue, 29 Oct 2019 10:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191024215438.138489-1-ebiggers@kernel.org> <20191024215438.138489-2-ebiggers@kernel.org>
In-Reply-To: <20191024215438.138489-2-ebiggers@kernel.org>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Tue, 29 Oct 2019 10:47:50 -0700
Message-ID: <CA+_SqcCefZRWL2xHRwFABupXyBdq9=jgBK_9gy-_4o-yFXG+Tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fscrypt: add support for IV_INO_LBLK_64 policies
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 24 Oct 2019 at 14:57, Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst | 63 +++++++++++++++++----------
>  fs/crypto/crypto.c                    | 10 ++++-
>  fs/crypto/fscrypt_private.h           | 16 +++++--
>  fs/crypto/keyring.c                   |  6 ++-
>  fs/crypto/keysetup.c                  | 45 ++++++++++++++-----
>  fs/crypto/policy.c                    | 41 ++++++++++++++++-
>  include/linux/fscrypt.h               |  3 ++
>  include/uapi/linux/fscrypt.h          |  3 +-
>  8 files changed, 146 insertions(+), 41 deletions(-)

I don't understand all of this, but the crypto-relevant part looks good to me.

Reviewed-By: Paul Crowley <paulcrowley@google.com>
