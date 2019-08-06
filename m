Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAA83A93
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2019 22:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHFUpL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Aug 2019 16:45:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39643 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfHFUpL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Aug 2019 16:45:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so8511063lfn.6
        for <linux-ext4@vger.kernel.org>; Tue, 06 Aug 2019 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNvWstZCi3NXF5KJDOazsGSKWj42nw3rueoSXYGmGRc=;
        b=dHVvyaXFUfwdTrXm8Qxe3g47TjDPWLCdOevoaBSnsuB2cWvNXEXQshBBZ2xZ66S7gF
         dDcbZzQwewKYPA4UdVMJKe+OULJcTBNQRzBEpqMJtuldr2635kPtBlgaOJqp7jvup6Ax
         2vW3nYb6r+xDz87ptI4JAiQyQuYpbmMXpvlUN04K30/rtTwPeJM0ZXVBbg5JrFVgVC6X
         TBupMMeehgE7wdlI130er0HeQc0ZJzdmc/c0HBvb/zb3EkUecBEQJthkHIywW1i3UI3k
         hoUKHmZFqSoR2uZzN5Z42y/WAneWxoHJkgWOGaDPO+v7fcApJ9Sd6+EPurKzfbO0Qzx7
         FJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNvWstZCi3NXF5KJDOazsGSKWj42nw3rueoSXYGmGRc=;
        b=oexnHFLuYagsjanQK4Y8poSnG1zXZR3yPW0/T0yuHbCQ8iyt9Ju/9PPgxQSYXfLIwg
         eboTjAbsq3dwlKv4l+NEz/O+WmfNwZTgxdNljWA7Kn/cgm8nIMr2H4zObeiyKnOOAIQP
         nKQ78a80+Pua0sEv42F8nDsqN0xtjO2s1Umh8q5jYSuC87fl1K989IN+TXBcAy+rxcS5
         P+OTUByg0UzyBYomgtUN6yuM9kjBs+BRnDGjOOLpLNJgZ6ZYXIsosoE9S6BZqhseWMZw
         YimxJ+hVXF/yM7wigvp3WS42D6c45zZxe17Yul+G28G598P2Y60OL8cyiP0V5rzyCSk+
         Aunw==
X-Gm-Message-State: APjAAAW4cHWrucWvnw1yng/4E9A5KP2ZmBQkXukWednc48LUuB4SjW20
        PCeVRVmI2P0tay6Y6u3ie1JXIVrNztgE+wcKr85z9g==
X-Google-Smtp-Source: APXvYqytA61jT3xOdp0Ac43cHqnLjnFVkdCXmd0Vh+wU5xDCKIN1tOrExheH0FZXClBUGoxDy7me4b7UmNyIp24tkW4=
X-Received: by 2002:ac2:54bc:: with SMTP id w28mr3504887lfk.17.1565124308213;
 Tue, 06 Aug 2019 13:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190805162521.90882-1-ebiggers@kernel.org> <20190805162521.90882-14-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-14-ebiggers@kernel.org>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Tue, 6 Aug 2019 13:44:56 -0700
Message-ID: <CA+_SqcAWniLLTk4eqWX81ypgMqnh2_9N=0JDKs3JopeV6XX_HA@mail.gmail.com>
Subject: Re: [PATCH v8 13/20] fscrypt: v2 encryption policy support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 5 Aug 2019 at 09:28, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add a new fscrypt policy version, "v2".  It has the following changes
> from the original policy version, which we call "v1" (*):
>
> - Master keys (the user-provided encryption keys) are only ever used as
>   input to HKDF-SHA512.  This is more flexible and less error-prone, and
>   it avoids the quirks and limitations of the AES-128-ECB based KDF.
>   Three classes of cryptographically isolated subkeys are defined:
>
>     - Per-file keys, like used in v1 policies except for the new KDF.
>
>     - Per-mode keys.  These implement the semantics of the DIRECT_KEY
>       flag, which for v1 policies made the master key be used directly.
>       These are also planned to be used for inline encryption when
>       support for it is added.
>
>     - Key identifiers (see below).
>
> - Each master key is identified by a 16-byte master_key_identifier,
>   which is derived from the key itself using HKDF-SHA512.  This prevents
>   users from associating the wrong key with an encrypted file or
>   directory.  This was easily possible with v1 policies, which
>   identified the key by an arbitrary 8-byte master_key_descriptor.
>
> - The key must be provided in the filesystem-level keyring, not in a
>   process-subscribed keyring.
>
> The following UAPI additions are made:
>
> - The existing ioctl FS_IOC_SET_ENCRYPTION_POLICY can now be passed a
>   fscrypt_policy_v2 to set a v2 encryption policy.  It's disambiguated
>   from fscrypt_policy/fscrypt_policy_v1 by the version code prefix.
>
> - A new ioctl FS_IOC_GET_ENCRYPTION_POLICY_EX is added.  It allows
>   getting the v1 or v2 encryption policy of an encrypted file or
>   directory.  The existing FS_IOC_GET_ENCRYPTION_POLICY ioctl could not
>   be used because it did not have a way for userspace to indicate which
>   policy structure is expected.  The new ioctl includes a size field, so
>   it is extensible to future fscrypt policy versions.
>
> - The ioctls FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY,
>   and FS_IOC_GET_ENCRYPTION_KEY_STATUS now support managing keys for v2
>   encryption policies.  Such keys are kept logically separate from keys
>   for v1 encryption policies, and are identified by 'identifier' rather
>   than by 'descriptor'.  The 'identifier' need not be provided when
>   adding a key, since the kernel will calculate it anyway.
>
> This patch temporarily keeps adding/removing v2 policy keys behind the
> same permission check done for adding/removing v1 policy keys:
> capable(CAP_SYS_ADMIN).  However, the next patch will carefully take
> advantage of the cryptographically secure master_key_identifier to allow
> non-root users to add/remove v2 policy keys, thus providing a full
> replacement for v1 policies.
>
> (*) Actually, in the API fscrypt_policy::version is 0 while on-disk
>     fscrypt_context::format is 1.  But I believe it makes the most sense
>     to advance both to '2' to have them be in sync, and to consider the
>     numbering to start at 1 except for the API quirk.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Paul Crowley <paulcrowley@google.com>
